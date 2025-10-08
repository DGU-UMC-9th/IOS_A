//
//  MovieFeed.swift
//  MegaBox
//
//  Created by 김도연 on 10/1/25.
//

import SwiftUI

struct MovieFeedView: View {
    var movie: MovieFeed
    
    var body: some View {
        HStack(alignment: .top) {
            movie.posterImage
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            VStack(alignment: .leading, spacing: 24) {
                Text(movie.title)
                    .font(.semiBold18)
                    .lineLimit(2)
                Text(movie.description)
                    .font(.semiBold13)
                    .foregroundStyle(.gray04)
            }
            .padding(.leading, 8)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
    }
}

#Preview {
    MovieFeedView(movie: HomeViewModel().feedList[0])
}
