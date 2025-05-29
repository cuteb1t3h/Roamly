//
//  FeedViewModel.swift
//  Roamly
//
//  Created by Настя on 06.04.2025.
//

import Foundation
import MapKit

class FeedViewModel: ObservableObject {
//    @Published var posts: [TravelPost] = [
//        TravelPost(
//            username: "any_kriz",
//            title: "Paris",
//            coordinate: .init(latitude: 52.52, longitude: 13.405),
//            images: ["city1", "city2", "city3"],
//            likes: 12, date: "2025-05-01"
//        ),
//        TravelPost(
//            username: "any_kri",
//            title: "Prage",
//            coordinate: .init(latitude: 48.8566, longitude: 2.3522),
//            images: ["city1", "city2", "city3"],
//            likes: 20, date: "2025-01-05"
//        )
//    ]
    @Published var posts: [TravelPost] = []
    
    func addPost(_ post: TravelPost) {
        posts.append(post)
    }
    
    func fetchFeedPosts(userID: Int) {
        guard let url = URL(string: "http://192.168.0.105:8080/users/feed/\(userID)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error loading feed:", error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                let decodedPosts = try JSONDecoder().decode([PostResponse].self, from: data)
                DispatchQueue.main.async {
                    self.posts = []
                    for decoded in decodedPosts {
                        let post = TravelPost(
                            username: decoded.username,
                            title: decoded.title,
                            coordinate: CLLocationCoordinate2D(latitude: decoded.latitude ?? 0, longitude: decoded.longitude ?? 0),
                            images: decoded.media,
                            likes: decoded.likes,
                            date: decoded.date
                        )
                        self.posts.append(post)
                    }
                }
            } catch {
                print("Error decoding feed data:", error)
            }
        }.resume()
    }
}
