//
//  PostManager.swift
//  Roamly
//
//  Created by Настя on 19.05.2025.
//

import Foundation
import CoreLocation

struct PostResponse: Decodable {
    var id: UInt32
    var username: String
    var title: String
    var latitude: Double?
    var longitude: Double?
    var media: [String]
    var likes: Int
    var date: String
}

class PostManager: ObservableObject {
    @Published var posts: [TravelPost] = []
    
    func addPost(_ post: TravelPost) {
        posts.append(post)
    }
    
    func fetchPosts(userID: Int) {
        guard let url = URL(string: "http://192.168.31.170:8080/posts/\(userID)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error loading photos:", error?.localizedDescription ?? "Unknown error")
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
                print("Error decoding photos:", error)
            }
        }.resume()
    }
}
