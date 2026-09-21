//
//  ArticleRowView.swift
//  TheNewsAPI
//
//  Created by Manyuchi, Carrington C on 2026/09/21.
//

import SwiftUI

struct ArticleRowView: View {
    let datum: Datum
    
    var body: some View {
        HStack(alignment: .top) {
                AsyncImage(url: URL(string: datum.imageURL)) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.thinMaterial)
                            .frame(width: 80, height: 80)
                            .overlay(content: {
                                ProgressView()
                            })
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        
                    case .failure(_):
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.thinMaterial)
                            .frame(width: 80, height: 80)
                            .overlay(content: {
                                Image(systemName: "pjoto")
                                    .foregroundStyle(.secondary)
                            })
                    @unknown default:
                        EmptyView()
                    }
                }
            
            VStack(alignment: .leading) {
                Text(datum.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text(datum.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
    }
}

#Preview {
    ArticleRowView(
        datum: .init(
            title: "Title",
            description: "description",
            url: "URL",
            imageURL: "IMGURL",
            publishedAt: "Date"
        )
    )
    .padding()
}
