//
//  PhotoManager.swift
//  Roamly
//
//  Created by Настя on 19.05.2025.
//

import Foundation

class PhotoManager: ObservableObject {
    @Published var photos: [Photo] = []

    func fetchPhotos(userID: Int) {
        guard let url = URL(string: "http://192.168.31.170:8080/photos/\(userID)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error loading photos:", error?.localizedDescription ?? "Unknown error")
                return
            }

            do {
                let decodedPhotos = try JSONDecoder().decode(Photo.self, from: data)
                DispatchQueue.main.async {
                    self.photos = [decodedPhotos]
                }
            } catch {
                print("Error decoding photos:", error)
            }
        }.resume()
    }
}
