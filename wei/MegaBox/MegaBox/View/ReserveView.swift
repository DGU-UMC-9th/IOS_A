//
//  ReserveView.swift
//  MegaBox
//
//  Created by 이연우 on 10/12/25.
//

import Foundation
import SwiftUI

struct ReserveView: View {
    
    let rows = Array(repeating: GridItem(.flexible()), count: 4)
    
    @StateObject private var vm = ReserveViewModel()
    @State private var calendarVM = CalendarViewModel()
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing:20){
            Navigation
            MovieSelection
            TheaterSelection
            WeekCalendarView(viewModel: calendarVM, reserveVM: vm)
                .padding(.horizontal,24)
            ScreenSelection
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .navigationDestination(for: String.self) { value in
            switch value {
            case "검색": MovieSearchView()
            default: EmptyView()
            }
        }
    }
    

    
    private var Navigation : some View {
            VStack {
                Text("영화별 예매")
                    .font(.bold22)
                    .foregroundStyle(Color.white)
            }
            .padding(.bottom,10)
            .frame(maxWidth: .infinity)
            .background(Color.purple03)
    }
    
    
    private var MovieSelection : some View {
        VStack {
            HStack{
                RoundedRectangle(cornerRadius: 4)
                    .foregroundStyle(Color.orange)
                    .overlay(
                        Text(vm.selectedMovie?.age.description ?? " ")
                            .font(.bold18)
                            .foregroundStyle(Color.white)
                    )
                    .frame(width:24,height: 24)
                Spacer()
                Text(vm.selectedMovie?.name ?? " ")
                    .font(.bold18)
                    .foregroundStyle(Color.black)
                    .frame(width: 238, alignment: .topLeading)
                Spacer()
                Button(action:{
                    path.append("검색")
                }, label:{
                    Text("전체영화")
                            .font(.semiBold14)
                            .foregroundStyle(Color.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                })
            }
            .padding(.horizontal,20)
            .frame(width:400)
            
            
            ScrollView(.horizontal){
                LazyHStack {
                    ForEach(vm.movies) { movie in
                        Button {
                            vm.selectedMovie = movie
                        } label: {
                            ZStack(alignment: .bottomLeading) {
                                Image(movie.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width:80, height:100)
                            }
                            .border(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(vm.selectedMovie?.id == movie.id ? Color.purple03 : Color.clear, lineWidth: 2)
                            )
                            
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .frame(width:400, height:100)
            
            
        }
        .padding(.horizontal, 24)
        
    }
    
    private var TheaterSelection : some View {
        HStack{
            ForEach(vm.regions, id: \.self) { region in
                let isOn = vm.isRegionSelected(region)
                
                Button {
                    vm.toggleRegion(region)
                } label: {
                    Text(region)
                        .font(.semiBold16)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .frame(minHeight: 36)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isOn ? Color.purple03 : Color.gray01)
                        )
                        .foregroundStyle(isOn ? Color.white : Color.gray05)
                }
                
            }
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal,24)
    }
    
    private var ScreenSelection: some View {
        ScrollView{
            
            let groupedByRegion: [String: [ReserveViewModel.Showtimes]] = Dictionary(
                grouping: vm.filteredShowtimes,
                by: { $0.theater.region ?? "기타" }
            )

            
            let orderedRegions: [String] = {
                if !vm.selectedRegions.isEmpty {
                    return Array(vm.selectedRegions).sorted()
                } else {
                    return Array(groupedByRegion.keys).sorted()
                }
            }()

            return VStack(alignment: .leading, spacing: 24) {
                ForEach(orderedRegions, id: \.self) { region in
                    if let items = groupedByRegion[region], !items.isEmpty {
                        
                        Text(region)
                            .font(.bold18)
                            .foregroundStyle(Color.black)
                            .padding(.horizontal, 20)

                        
                        ForEach(items) { group in
                            TheaterGrid(showtimes: group)
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(.horizontal, 28)
        
    }
    
    private func TheaterGrid(showtimes: ReserveViewModel.Showtimes) -> some View {
        
        let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)

        
        let infos = Array(Set(showtimes.times.map { $0.info })).sorted()
        let rightLabel = infos.count == 1 ? infos.first : nil

        return VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(showtimes.theater.name)
                    .font(.semiBold16)
                    .foregroundStyle(Color.black)
                Spacer()
                if let label = rightLabel {
                    Text(label)
                        .font(.semiBold14)
                        .foregroundStyle(Color.black)
                }
            }

            LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
                ForEach(showtimes.times) { sc in
                    ScreeningTimeCell(screening: sc)   // 아래 함수
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func ScreeningTimeCell(screening: ScreeningModel) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(timeHM(screening.startAt))
                .font(.bold18)
                .foregroundStyle(Color.black)

            
            Text("~\(timeHM(screening.endAt))")
                .font(.regular12)
                .foregroundStyle(Color.gray03)

            
            HStack(spacing: 1) {
                Text(twoDigits(screening.seatsAvailable))
                    .font(.regular13)
                    .foregroundStyle(Color.purple03)
                Text("/ \(screening.seatsTotal)")
                    .font(.regular13)
                    .foregroundStyle(Color.gray03)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, minHeight: 88, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.gray02, lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 14).fill(Color.white)
                )
        )
    }
    
    private func timeHM(_ date: Date) -> String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "HH:mm"
        return f.string(from: date)
    }

    private func twoDigits(_ n: Int) -> String {
        String(format: "%02d", n)
    }



    
}


#Preview {
    ReserveView(path: .constant(NavigationPath()))
}
