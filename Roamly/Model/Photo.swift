//
//  Photo.swift
//  Roamly
//
//  Created by Настя on 19.05.2025.
//

import Foundation

struct Photo: Identifiable, Codable {
    var user_id: Int
    var media: String
    var description: String
}
