//
//  VideoViewModel.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 21/09/24.
//

import Foundation

class VideoViewModel: ObservableObject {
    @Published var videos: [Video] = []
    @Published var isLoading: Bool = false
    
    func fetchData() throws {
        guard let url = URL(string: "http://10.7.5.63:3000/videos") else {
            print("Invalid URL")
            return
        }
        
        self.isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let videos = try JSONDecoder().decode([Video].self, from: data)
                    DispatchQueue.main.async {
                        self.videos = videos
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

