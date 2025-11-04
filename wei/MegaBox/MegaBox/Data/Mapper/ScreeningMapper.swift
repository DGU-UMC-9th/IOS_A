//
//  ScreeningMapper.swift
//  MegaBox
//
//  Created by 이연우 on 11/4/25.
//

import Foundation

struct ScreeningMapper {

    private static let dayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.timeZone = .current
        f.dateFormat = "yyyy-MM-dd"
        return f
    }()

    private static let timeFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.timeZone = .current
        f.dateFormat = "HH:mm"
        return f
    }()

    
    static func toDomain(
        from showtime: ShowtimesDTO, item: AreaItemDTO,
        movieId: UUID,
        theaterId: UUID,
        date: String
    ) -> ScreeningModel? {

        guard
            let day = dayFormatter.date(from: date),
            let startTime = timeFormatter.date(from: showtime.start),
            let endTime = timeFormatter.date(from: showtime.end)
        else { return nil }

        var cal = Calendar.current
        var startComp = cal.dateComponents([.year, .month, .day], from: day)
        var endComp   = startComp

        let startClock = cal.dateComponents([.hour, .minute], from: startTime)
        let endClock   = cal.dateComponents([.hour, .minute], from: endTime)
        startComp.hour = startClock.hour
        startComp.minute = startClock.minute
        endComp.hour = endClock.hour
        endComp.minute = endClock.minute

        guard let startAt = cal.date(from: startComp),
              var endAt   = cal.date(from: endComp) else { return nil }

        // 자정 넘어감 보정
        if endAt <= startAt {
            endAt = cal.date(byAdding: .day, value: 1, to: endAt) ?? endAt
        }

        return ScreeningModel(
            movieId: movieId,
            theaterId: theaterId,
            info: item.format,     
            startAt: startAt,
            endAt: endAt,
            seatsTotal: showtime.total,
            seatsAvailable: showtime.available
        )
    }
}

