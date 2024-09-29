//
//  ServicePhoneViewModel.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 12/09/24.
//

import Foundation

class ServicePhoneViewModel: ObservableObject {
    @Published var servicePhones: [ServicePhone] = []
    @Published var isLoading: Bool = false
    
    func fetchData() throws {
        guard let url = URL(string: "http://192.168.2.11:3000/service-phone") else {
            print("Invalid URL")
            return
        }
        
        self.isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let servicePhones = try JSONDecoder().decode([ServicePhone].self, from: data)
                    DispatchQueue.main.async {
                        self.servicePhones = servicePhones
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
