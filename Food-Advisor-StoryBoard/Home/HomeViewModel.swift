//
//  HomeViewModel.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 24.03.23.
//

import Foundation

final class HomeViewModel {
    public var posts = [Post]()
    private let networkManager = NetworkManager()
    private var skip = 0
    
    func getPosts(completion: @escaping () -> Void) {
        networkManager.loadData(skip: skip) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                self.posts.append(contentsOf: data.posts)
                completion()
                self.skip += 10
            case .failure(let error):
                print(NetworkError.unknownError(error))
            }
        }
    }
}
