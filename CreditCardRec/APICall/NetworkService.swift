//
//  NetworkService.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 5/6/25.
//


// NetworkService.swift

import Foundation

enum NetworkError: Error {
    case badURL, requestFailed, decodeFailed
}

final class NetworkService {
    static let shared = NetworkService()
    private init() {}

    func fetchPosts() async throws -> [Post] {
        // 1. Build URL
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            throw NetworkError.badURL
        }
        // 2. Perform request
        let (data, response) = try await URLSession.shared.data(from: url)
        // 3. Check HTTP status
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw NetworkError.requestFailed
        }
        // 4. Decode JSON
        do {
            let posts = try JSONDecoder().decode([Post].self, from: data)
            return posts
        } catch {
            throw NetworkError.decodeFailed
        }
    }
}
