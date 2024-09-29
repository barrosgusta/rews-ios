//
//  MyError.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 19/09/24.
//

public enum NetworkError: Error {
    case noInternetConnection
    case serverError
    case unauthorized
    case notFound
    case unknown
    case ApiError(message: String)
    case ApiBaseUrlNotSet
    case parsingError
    case invalidURL
    case invalidData
    case invalidResponse
    case decodingError
    case encodingError
}
