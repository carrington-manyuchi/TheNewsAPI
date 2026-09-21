//
//  ContentView.swift
//  TheNewsAPI
//
//  Created by Manyuchi, Carrington C on 2026/09/19.
//

import SwiftUI

struct NewsHeadlinesview: View {
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
                if newsViewmodel.isLoading {
                    ProgressView("Loading...")
                }  else {
                    List {
                        ForEach(newsViewmodel.article.data) { article in
                            //MARK: - TODO - Article Row View
                            Text(article.title)
                        }
                    }
                }
                
                Text("News")
            }
            .alert("Error", isPresented: .constant(newsViewmodel.errorMessage != nil), actions: {
                Button("OK") {
                    newsViewmodel.errorMessage = nil
                }
            })
            .navigationTitle("Top Headlines")
            .task {
                await newsViewmodel.fetchHeadlines()
            }
        }
    }
}

#Preview {
    NewsHeadlinesview()
}
