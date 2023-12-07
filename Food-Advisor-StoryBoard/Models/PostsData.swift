//
//  PostsData.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 24.03.23.
//

import Foundation

struct PostsData: Decodable {
    let posts: [Post]
}
struct Post: Decodable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}
