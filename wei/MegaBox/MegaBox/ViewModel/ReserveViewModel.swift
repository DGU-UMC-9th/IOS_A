//
//  ReserveViewModel.swift
//  MegaBox
//
//  Created by 이연우 on 10/12/25.
//

import Foundation
import Combine
import SwiftUI

final class ReserveViewModel: ObservableObject {

    struct Showtimes: Identifiable, Hashable {
        let id: UUID
        let theater: TheaterModel
        let times: [ScreeningModel]
    }

    // 이미 로컬에 있는 영화들 (id = UUID)
    @Published private(set) var movies: [MovieModel] = [
        .init(name:"어쩔수가없다", imageName: "djWjftnrk", audience:"20만", age:15),
        .init(name:"귀멸의 칼날: 무한성", imageName:"infinityCastle", audience:"60만",age:15),
        .init(name:"F1 더 무비", imageName: "f1" , audience:"10만",age:12),
        .init(name:"보스", imageName: "boss" , audience:"30만",age:15),
        .init(name:"모노노케 히메", imageName: "mononoke" , audience:"40만",age:12),
        .init(name:"야당", imageName: "yaDang" , audience:"50만",age:18),
        .init(name:"얼굴", imageName: "face" , audience:"70만",age:12),
        .init(name:"the Roses", imageName: "theRoses" , audience:"80만",age:15)
    ]

    
    @Published var theaters: [TheaterModel] = []

    @Published private(set) var screenings: [ScreeningModel] = []
    @Published var calendarViewModel = CalendarViewModel()
    @Published var selectedMovie: MovieModel? = nil
    @Published var selectedRegions: Set<String> = []
    @Published var selectedDate: Date? = Date()

    @Published private(set) var filteredShowtimes: [Showtimes] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private var bag = Set<AnyCancellable>()

    var regions: [String] {
        Array(Set(theaters.compactMap { $0.region })).sorted()
    }

    func isRegionSelected(_ region: String) -> Bool { selectedRegions.contains(region) }
    func toggleRegion(_ region: String) {
        if selectedRegions.contains(region) { selectedRegions.remove(region) }
        else { selectedRegions.insert(region) }
    }

    init() {
        pipeline()
        loadAndMergeShowtimes(fromResource: "MovieSchedule")
    }

    private func pipeline() {
        Publishers.CombineLatest3($selectedMovie, $selectedRegions, $selectedDate)
            .sink { [weak self] (movie, regions, date) in
                self?.filterShowtimes(movie: movie, regions: regions, date: date)
            }
            .store(in: &bag)
    }

    private func filterShowtimes(
        movie: MovieModel?,
        regions: Set<String>,
        date: Date?
    ) {
        guard let movie = movie, let date = date else {
            filteredShowtimes = []
            return
        }

        let allowedTheaters: [TheaterModel] =
            regions.isEmpty
            ? theaters
            : theaters.filter { th in
                guard let r = th.region else { return false }
                return regions.contains(r)
            }

        var result: [Showtimes] = []

        for th in allowedTheaters {
            let times = screenings
                .filter { s in
                    s.movieId == movie.id &&
                    s.theaterId == th.id &&
                    Calendar.current.isDate(s.startAt, inSameDayAs: date)
                }
                .sorted { $0.startAt < $1.startAt }

            if !times.isEmpty {
                result.append(.init(id: th.id, theater: th, times: times))
            }
        }

        filteredShowtimes = result.sorted { $0.theater.name < $1.theater.name }
    }
}

// MARK: - JSON 로드 & 병합
extension ReserveViewModel {

    func loadAndMergeShowtimes(fromResource name: String, ext: String = "json") {
        Task { await loadAndMergeShowtimesAsync(fromResource: name, ext: ext) }
    }

    @MainActor
    private func loadAndMergeShowtimesAsync(fromResource name: String, ext: String) async {
        isLoading = true
        defer { isLoading = false }

        do {
            guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
                errorMessage = "파일을 찾을 수 없어요: \(name).\(ext)"
                print("❌ 파일 없음: \(name).\(ext)")
                return
            }
            
            guard FileManager.default.fileExists(atPath: url.path) else {
                errorMessage = "파일이 존재하지 않아요: \(url.lastPathComponent)"
                print("❌ 파일 경로 없음: \(url.path)")
                return
            }
            
            print("✅ JSON 파일 찾음: \(url.lastPathComponent)")
            
            let data = try await Task.detached(priority: .userInitiated) {
                try Data(contentsOf: url)
            }.value

            print("✅ JSON 데이터 로드 완료: \(data.count) bytes")

            // ✅ 수정: APIResponse로 디코딩 후 data 추출
            let decoder = JSONDecoder()
            let response = try decoder.decode(APIResponse.self, from: data)
            let dataDTO = response.data
            
            print("✅ JSON 디코딩 완료")
            print("   - Status: \(response.status)")
            print("   - 영화 수: \(dataDTO.movies.count)")
            
            try await mergeOnlyTargetMovies(from: dataDTO)

        } catch let DecodingError.keyNotFound(key, context) {
            print("❌ 디코딩 에러 - 키를 찾을 수 없음: \(key.stringValue)")
            print("   경로: \(context.codingPath)")
            print("   설명: \(context.debugDescription)")
            errorMessage = "JSON 형식 오류: \(key.stringValue) 키가 없습니다."
        } catch let DecodingError.typeMismatch(type, context) {
            print("❌ 디코딩 에러 - 타입 불일치: \(type)")
            print("   경로: \(context.codingPath)")
            print("   설명: \(context.debugDescription)")
            errorMessage = "JSON 형식 오류: 타입이 맞지 않습니다."
        } catch {
            print("❌ Showtimes load/decode error:", error)
            errorMessage = "상영정보 로드에 실패했어요. (\(error.localizedDescription))"
        }
    }

    @MainActor
    private func mergeOnlyTargetMovies(from dataDTO: ShowtimesDataDTO) async throws {

        var existingTheaterByKey: [String: TheaterModel] = [:]
        for th in theaters {
            let key = "\(th.region ?? "")|\(th.name)"
            existingTheaterByKey[key] = th
        }

        var byMovie = Dictionary(grouping: screenings, by: { $0.movieId })
        
        var totalNewTheaters = 0
        var totalNewScreenings = 0

        for movieDTO in dataDTO.movies {
            guard let idx = indexOfLocalMovie(for: movieDTO, in: movies) else {
                print("⚠️ 로컬에 없는 영화 스킵: \(movieDTO.title)")
                continue
            }
            
            let movieId = movies[idx].id
            movies[idx].serverId = movieDTO.id
            
            print("✅ 영화 매칭: \(movieDTO.title) → \(movies[idx].name)")

            var newTheaters: [TheaterModel] = []
            var newScreenings: [ScreeningModel] = []

            for schedule in movieDTO.schedules {
                print("   📅 날짜: \(schedule.date)")
                
                for area in schedule.areas {
                    print("      📍 지역: \(area.area)")
                    
                    for item in area.items {
                        let key = "\(area.area)|\(item.auditorium)"
                        let theater: TheaterModel = {
                            if let existed = existingTheaterByKey[key] {
                                return existed
                            } else {
                                let th = TheaterMapper.toDomain(from: area, item: item)
                                existingTheaterByKey[key] = th
                                newTheaters.append(th)
                                print("         🏛️ 새 극장: \(th.name)")
                                return th
                            }
                        }()

                        for st in item.showtimes {
                            if let sc = ScreeningMapper.toDomain(
                                from: st,
                                item: item,
                                movieId: movieId,
                                theaterId: theater.id,
                                date: schedule.date
                            ) {
                                newScreenings.append(sc)
                            } else {
                                print("         ⚠️ 상영 정보 파싱 실패: \(st.start) - \(st.end)")
                            }
                        }
                    }
                }
            }

            var mergedTheaterById = Dictionary(uniqueKeysWithValues: theaters.map { ($0.id, $0) })
            for th in newTheaters { mergedTheaterById[th.id] = th }
            let mergedTheaters = Array(mergedTheaterById.values).sorted { $0.name < $1.name }

            byMovie[movieId] = newScreenings

            theaters = mergedTheaters
            screenings = byMovie.values.flatMap { $0 }
            
            totalNewTheaters += newTheaters.count
            totalNewScreenings += newScreenings.count
            
            print("   ✅ 이 영화 - 극장: \(newTheaters.count)개, 상영: \(newScreenings.count)개")
        }
        
        print("\n🎬 최종 데이터:")
        print("   - 전체 극장: \(theaters.count)개")
        print("   - 전체 상영: \(screenings.count)개")
        print("   - 지역: \(regions)")
        print("   - 새로 추가된 극장: \(totalNewTheaters)개")
        print("   - 새로 추가된 상영: \(totalNewScreenings)개")
    }

    private func normalize(_ s: String) -> String {
        s.lowercased()
         .replacingOccurrences(of: " ", with: "")
         .replacingOccurrences(of: ":", with: "")
         .replacingOccurrences(of: "[^a-z0-9가-힣]", with: "", options: .regularExpression)
    }

    private func indexOfLocalMovie(for dto: MovieDTO, in local: [MovieModel]) -> Int? {
        if let i = local.firstIndex(where: { $0.serverId == dto.id }) { return i }
        let target = normalize(dto.title)
        return local.firstIndex(where: { normalize($0.name) == target })
    }
}
