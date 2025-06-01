//
//  UserManager.swift
//  Roamly
//
//  Created by Настя on 19.05.2025.
//

import SwiftUI

struct UserResponse: Decodable {
    var id: UInt32
    var username: String
    var subscribes: Int
    var subscribers: Int
    var avatar: String
    var description: String
}

class UserManager: ObservableObject {
    @Published var user: User?
    @Published var avatarURL: String? = nil
    
    func fetchUser(userID: Int) {
        guard let url = URL(string: "http://192.168.31.170:8080/users/\(userID)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error loading user info:", error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                let decodedUser = try JSONDecoder().decode(UserResponse.self, from: data)
                DispatchQueue.main.async {
                    self.user = User(
                        id: Int(decodedUser.id),
                        username: decodedUser.username,
                        subscribes: decodedUser.subscribes,
                        subscribers: decodedUser.subscribers,
                        avatar: decodedUser.avatar,
                        description: decodedUser.description
                    )
                }
            } catch {
                print("Error decoding user info:", error)
            }
        }.resume()
    }
    
    func fetchUserAvatar(userID: Int) {
        guard let url = URL(string: "http://192.168.31.170:8080/users/\(userID)/avatar") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                  let avatarResponse = try? JSONDecoder().decode(AvatarResponse.self, from: data) else {
                print("Ошибка загрузки аватарки: \(error?.localizedDescription ?? "Неизвестная ошибка")")
                return
            }
            
            DispatchQueue.main.async {
                self.avatarURL = avatarResponse.avatarURL
            }
        }.resume()
    }
}

struct AvatarResponse: Codable {
    let avatarURL: String
}
