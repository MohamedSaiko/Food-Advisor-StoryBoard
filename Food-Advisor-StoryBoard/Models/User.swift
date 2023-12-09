//
//  User.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 24.03.23.
//

import Foundation

struct User: Codable {
    let id: Int
    let userName: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String
    let token: String
}

enum CodingKeys: String, CodingKey {
    case userName = "username"
}
