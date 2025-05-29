//
//  User.swift
//  Roamly
//
//  Created by Настя on 06.04.2025.
//

struct User: Codable {
    let id: Int
    let username: String
    let subscribes: Int
    let subscribers: Int
    let avatar: String
    let description: String
}
