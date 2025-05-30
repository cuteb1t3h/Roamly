//
//  FeedPost.swift
//  Roamly
//
//  Created by Настя on 29.05.2025.
//

import Foundation
import CoreLocation

struct FeedPost: Identifiable {
    let id = UUID()
    var username: String
    var title: String
    var coordinate: CLLocationCoordinate2D
    var images: [String]
    var likes: Int
    var date: String
    var avatar: String
}
