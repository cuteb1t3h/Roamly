//
//  FeedManager.swift
//  Roamly
//
//  Created by Настя on 29.05.2025.
//

import Foundation
import CoreLocation

struct FeedPostResponse: Decodable {
    var username: String
    var title: String
    var latitude: Double?
    var longitude: Double?
    var media: [String]
    var likes: Int
    var date: String
    var avatar: String
}

class FeedManager: ObservableObject {
    @Published var posts: [FeedPost] = []
    
    func addPost(_ post: FeedPost) {
        posts.append(post)
    }
    
    func fetchFeedPosts(userID: Int) {
        guard let url = URL(string: "http://192.168.31.170:8080/users/feed/\(userID)") else { return }
        print(userID)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error loading feed:", error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                let decodedPosts = try JSONDecoder().decode([FeedPostResponse].self, from: data)
                DispatchQueue.main.async {
                    self.posts = []
                    for decoded in decodedPosts {
                        let post = FeedPost(
                            username: decoded.username,
                            title: decoded.title,
                            coordinate: CLLocationCoordinate2D(latitude: decoded.latitude ?? 0, longitude: decoded.longitude ?? 0),
                            images: decoded.media,
                            likes: decoded.likes,
                            date: decoded.date,
                            avatar: decoded.avatar
                        )
                        self.posts.append(post)
                    }
                }
            } catch {
                print("Error decoding feed data:", error)
            }
        }.resume()
    }
    
    func getCityName(from coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                completion(placemark.locality ?? placemark.administrativeArea ?? placemark.country)
            } else {
                completion(nil)
            }
        }
    }
}
