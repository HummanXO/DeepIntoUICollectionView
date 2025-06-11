//
//  APIService.swift
//  DeepIntoUICollectionView
//
//  Created by Aleksandr on 10.06.2025.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .invalidData:
            return "Invalid data"
        case .decodingFailed:
            return "Decoding failed"
        }
    }
}

struct APIService {
    let baseURL = "https://api.unsplash.com/"
    
    func getPhotos(page: Int = 1, perPage: Int = 12) async throws -> WelcomeDTO {
        guard let url = URL(string: "\(baseURL)photos?page=\(page)&per_page=\(perPage)") else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID Hm8S4ECIMPJCWvZ5u8OFNhjHWRcFOrBSwUulHXtzs9k", forHTTPHeaderField: "Authorization")
        
        var (data, response) : (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            fatalError("Error fetching data")
        }
        
        guard
            let urlResponse = response as? HTTPURLResponse,
            urlResponse.statusCode == 200
        else {
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let welcome = try decoder.decode(WelcomeDTO.self, from: data)
            return welcome
        } catch let decodingError as DecodingError {
            switch decodingError {
            case .dataCorrupted(let context):
                print("❌ Data corrupted: \(context.debugDescription)")
                if context.debugDescription.contains("date") {
                    print("📅 Плохая дата! \(context.codingPath)")
                }
            case .keyNotFound(let key, let context):
                print("❌ Key '\(key)' not found: \(context.debugDescription)")
            case .typeMismatch(let type, let context):
                print("❌ Type mismatch: \(type) — \(context.debugDescription)")
            case .valueNotFound(let value, let context):
                print("❌ Value '\(value)' not found: \(context.debugDescription)")
            @unknown default:
                print("❌ Unknown decoding error")
            }
            throw APIError.decodingFailed
        }
    }
}

