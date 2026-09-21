//
//  ArticleViewModel.swift
//  TheNewsAPI
//
//  Created by Manyuchi, Carrington C on 2026/09/21.
//

import Foundation
import Combine


@Observable
@MainActor class NewsViewModel: ObservableObject {
    var newsModel: NewsModel = NewsModel(data: [])
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let apiKey = "AZNAaUpd2ctqIZaYlH5CNqjVq3I2RjWygG6e0JWe"
    
    
    init() {
        Task {
            await fetchHeadlines()
        }
    }
    
    func fetchHeadlines() async  {
        isLoading = true
        errorMessage = nil
        
        let urlString = "https://api.thenewsapi.com/v1/news/top?api_token=\(apiKey)&locale=us&limit=3"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(NewsModel.self, from: data)
            self.newsModel = decoded
        } catch {
            errorMessage = "Failed to load news: \(error.localizedDescription)"
        }
            
        self.isLoading = false
    }
}
