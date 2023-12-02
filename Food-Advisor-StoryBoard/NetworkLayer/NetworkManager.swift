//
//  NetworkManager.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 24.03.23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError
    case decodingError
    case unknownError(Error)
}

struct NetworkManager {
    func loadData(completion: @ escaping (Result<PostsData, NetworkError>) -> Void) {
        let url = URL(string: allPostsUrl)
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(.networkError))
                return
            }
            do {
                let jsonPetitions = try JSONDecoder().decode(PostsData.self, from: data)
                completion(.success(jsonPetitions))
            }
            catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        task.resume()
    }
}
