//
//  ArticleViewModel.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 12/09/24.
//

import Foundation

class ArticleViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    
    func fetchData() {
        guard let url = URL(string: "http://10.7.5.63:3000/articles") else {
            print("Invalid URL")
            return
        }
        
        self.isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let articles = try JSONDecoder().decode([Article].self, from: data)
                    DispatchQueue.main.async {
                        self.articles = articles
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }.resume()
    }
}
