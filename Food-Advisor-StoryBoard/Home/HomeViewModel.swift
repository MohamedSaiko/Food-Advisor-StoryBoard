//
//  HomeViewModel.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 24.03.23.
//

import Foundation

final class HomeViewModel {
    
    private let networkManager: NetworkManager
    var posts = [Post]()
    private var skip = 0
    private let totalNumberOfPosts = 150
    
    init(networkManager: NetworkManager){
        self.networkManager = networkManager
    }
    
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
    
    func checkForLastCell(with indexPath: IndexPath, completion: () -> Void) {
        if indexPath.row == posts.count - 1, posts.count < totalNumberOfPosts {
            completion()
        }
    }
}
