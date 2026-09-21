//
//  ContentView.swift
//  TheNewsAPI
//
//  Created by Manyuchi, Carrington C on 2026/09/19.
//

import SwiftUI
import WebKit

struct NewsHeadlinesView: View {
    @State private var newsViewmodel = NewsViewModel()
    let background: some View = LinearGradient(
        colors: [.blue.opacity(0.2), .purple.opacity(0.3)] ,
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                
                 //MARK: - List of articles
                List {
                    ForEach(newsViewmodel.newsModel.data) { newsModel in
                        NavigationLink {
                            WebView(url: URL(string: newsModel.url))
                        } label: {
                            ArticleRowView(datum: newsModel)
                        }
                    }
                }
                
                if newsViewmodel.isLoading {
                    ProgressView("Loading...")
                        .font(.headline)
                        .padding()
                        .background(
                            .ultraThinMaterial,
                            in: RoundedRectangle(
                                cornerRadius: 16
                            )
                        )
                        .shadow(radius: 10)
                }
                
                Text("News")
            }
            .alert("Error", isPresented: .constant(newsViewmodel.errorMessage != nil)) {
                Button("OK") {
                    newsViewmodel.errorMessage = nil
                }
            } message: {
                Text(newsViewmodel.errorMessage ?? "")
            }
            .navigationTitle("Top Headlines")
            .refreshable {
                await newsViewmodel.fetchHeadlines()
            }
        }
    }
}

#Preview {
    NewsHeadlinesView()
}
