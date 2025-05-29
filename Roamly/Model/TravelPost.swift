//
//  TravelPost.swift
//  Roamly
//
//  Created by Настя on 06.04.2025.
//

import Foundation
import CoreLocation

struct TravelPost: Identifiable {
    let id = UUID()
    var username: String
    var title: String
    var coordinate: CLLocationCoordinate2D
    var images: [String]
    var likes: Int
    var date: String
}

