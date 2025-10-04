//
//  MovieFeedView.swift
//  megabox
//
//  Created by 백지은 on 10/4/25.
//

import SwiftUI

struct MovieFeedView: View {
    
    var feedList: [MovieFeed]
    
    var body: some View {
        VStack{
            HStack{
                Text("알고보면 더 재밌는 무비 피드")
                    .font(.bold24)
                Spacer()
                Button{
                    
                } label: {
                    Image(systemName: "arrow.forward")
                        .foregroundStyle(.black)
                }
            }
            Image(.poster)
                .resizable()
                .aspectRatio(contentMode: .fit)
            listSection
        }
        .padding(.horizontal, 16)
    }
    
    private var listSection: some View {
            VStack(alignment: .leading, spacing: 30) {
                ForEach(feedList, id: \MovieFeed.title) { (feed: MovieFeed) in
                    HStack(spacing: 20) {
                        feed.posterImage
                        VStack(alignment: .leading, spacing: 25) {
                            Text(feed.title)
                                .font(.semiBold18)
                            Text(feed.description)
                                .font(.semiBold13)
                                .foregroundStyle(.gray03)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)
        }
}

#Preview {
    MovieFeedView(feedList: HomeViewModel().feedList)
}
