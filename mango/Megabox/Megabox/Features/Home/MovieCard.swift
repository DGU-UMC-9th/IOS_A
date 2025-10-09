//
//  MovieCard.swift
//  Megabox
//
//  Created by 송민교 on 10/6/25.
//

import SwiftUI

struct MovieCard: View {
    let movie: MovieModel
    @Environment(NavigationRouterViewModel.self) private var router
    
    var body: some View {
        @Bindable var router = router
        
        VStack(alignment: .leading) {
            Image(movie.movieImageName)
                .onTapGesture {
                    router.push(.detail(movie: movie))
                }
            Button(action: {}) {
                Text("바로 예매")
                    .foregroundStyle(Color.purple03)
                    .padding(.horizontal, 45.5)
                    .padding(.vertical, 8.5)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purple03, lineWidth: 1)
            )
            Text(movie.movieTitle)
                .font(.pretend(type: .bold, size: 22))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("누적관객 수 \(movie.movieCount)")
                .font(.pretend(type: .medium, size: 18))
        }
    }
}
