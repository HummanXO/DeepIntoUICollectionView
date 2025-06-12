//
//  APIService.swift
//  DeepIntoUICollectionView
//
//  Created by Aleksandr on 12.06.2025.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalideURL
    case invalidResponse
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalideURL:
            "Invalid URL"
        case .invalidResponse:
            "Invalide response"
        case .decodingFailed:
            "Decoding Failed"
        }
    }
}

struct APIService {
    let baseURLString = "https://api.unsplash.com/"
    
    func fetchPhotos(page: Int = 1, perPage: Int = 12) async throws -> PhotoDTO {
        guard
            let url = URL(string: "\(baseURLString)photos?page=\(page)&per_page=\(perPage)")
        else {
            throw APIError.invalideURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Client-ID Hm8S4ECIMPJCWvZ5u8OFNhjHWRcFOrBSwUulHXtzs9k", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(PhotoDTO.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}
