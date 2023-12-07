//
//  User.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 24.03.23.
//

import Foundation

struct User: Decodable {
    let username: String
    let firstName: String
    let lastName: String
    let token: String
}
