//
//  AuthenticationManager.swift
//  Food Advisor
//
//  Created by Mohamed Sayed on 24.03.23.
//

import Foundation

struct AuthenticationManager {
    
    func authenticate(userName: String, password: String, completion: @escaping ()->Void) {
        
        let urlString = authenticationUrl
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "Post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String:String] = [
        "username": userName,
        "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(String(describing: error))
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(User.self, from: data)
                completion()
                print("SUCCESS: \(response)")
            } catch {
                print(String(describing: error))
            }
        }
        task.resume()
    }
}

