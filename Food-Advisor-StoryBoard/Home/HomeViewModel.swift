//
//  HomeViewModel.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 24.03.23.
//

import Foundation

struct HomeViewModel {
    var posts = [Post]()
    private let networkManager = NetworkManager()
    
    mutating func getPosts(completion: @escaping (PostsData) -> Void) {
        networkManager.loadData { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(NetworkError.unknownError(error))
            }
        }
    }
}
