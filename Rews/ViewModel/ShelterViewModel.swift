//
//  ShelterViewModel.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 21/09/24.
//

import Foundation

class ShelterViewModel: ObservableObject {
    @Published var shelters: [Shelter] = []
    @Published var mainTown: SheltersMainTown? = nil
    @Published var isLoading: Bool = true
    
    func fetchShelters() throws {
        guard let url = URL(string: "http://10.7.5.63:3000/shelters") else {
            print("Invalid URL")
            return
        }
        
        self.isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let shelters = try JSONDecoder().decode([Shelter].self, from: data)
                    DispatchQueue.main.async {
                        self.shelters = shelters
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            } else if let error = error {
                print("Failed to fetch JSON: \(error)")
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }.resume()
    }
    
    func fetchSheltersMainTown(completion: @escaping (Result<SheltersMainTown, Error>) -> Void) throws {
        guard let url = URL(string: "http://10.7.5.63:3000/shelters/maintown") else {
            print("Invalid URL")
            return
        }
        
        self.isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let shelterMainTown = try JSONDecoder().decode(SheltersMainTown.self, from: data)
                    completion(.success(shelterMainTown))
                    DispatchQueue.main.async {
                        self.mainTown = shelterMainTown
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }.resume()
    }
}
