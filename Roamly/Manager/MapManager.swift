//
//  MapManager.swift
//  Roamly
//
//  Created by Настя on 30.05.2025.
//

//import Foundation
//import CoreLocation
//import MapKit
//import _MapKit_SwiftUI
//
//struct MapResponse: Decodable {
//    var latitude: Double?
//    var longitude: Double?
//    var date: String
//    var avatar: String
//}
//
//class MapManager: ObservableObject {
//    @Published var maps: [Map] = []
//    @Published var routeCoordinates: [CLLocationCoordinate2D] = []
//    @Published var cameraPosition = MapCameraPosition.region(
//        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.0, longitude: 15.0),
//                           span: MKCoordinateSpan(latitudeDelta: 20.0, longitudeDelta: 20.0))
//    )
//    
//    @Published var locations: [PostLocation] = []
//    @Published var userAvatar: UIImage?
//
//    var sortedLocations: [PostLocation] {
//        locations.sorted { $0.date < $1.date }
//    }
//    
//    func addPost(_ map: Map) {
//        maps.append(map)
//    }
//    
//    func fetchMap(userID: Int) {
//        guard let url = URL(string: "http://192.168.31.170:8080/users/map/\(userID)") else { return }
//        print(userID)
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error loading feed:", error?.localizedDescription ?? "Unknown error")
//                return
//            }
//            
//            do {
//                let decodedPosts = try JSONDecoder().decode([MapResponse].self, from: data)
//                DispatchQueue.main.async {
//                    self.maps = []
//                    for decoded in decodedPosts {
//                        let map = Map(
//                            coordinate: CLLocationCoordinate2D(latitude: decoded.latitude ?? 0, longitude: decoded.longitude ?? 0),
//                            date: decoded.date,
//                            avatar: decoded.avatar
//                        )
//                        self.maps.append(map)
//                    }
//                }
//            } catch {
//                print("Error decoding feed data:", error)
//            }
//        }.resume()
//    }
//    
//    func calculateRouteBetweenLocations() {
//        routeCoordinates = []
//        let sorted = sortedLocations
//        guard sorted.count > 1 else { return }
//
//        let group = DispatchGroup()
//
//        for i in 0..<sorted.count - 1 {
//            let source = MKMapItem(placemark: MKPlacemark(coordinate: sorted[i].coordinate))
//            let destination = MKMapItem(placemark: MKPlacemark(coordinate: sorted[i + 1].coordinate))
//
//            let request = MKDirections.Request()
//            request.source = source
//            request.destination = destination
//            request.transportType = .automobile
//
//            let directions = MKDirections(request: request)
//
//            group.enter()
//            directions.calculate { response, error in
//                defer { group.leave() }
//                guard let route = response?.routes.first else { return }
//
//                self.routeCoordinates.append(contentsOf: route.polyline.coordinates)
//            }
//        }
//
//        group.notify(queue: .main) {
//            // Когда все маршруты готовы — обновится карта
//            self.objectWillChange.send()
//        }
//    }
//    
//    func loadLocationsFromPosts(userID: Int) {
//        guard let url = URL(string: "http://192.168.31.170:8080/posts/\(userID)") else { return }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let data = data,
//                let posts = try? JSONDecoder().decode([Post].self, from: data)
//            else { return }
//
//            DispatchQueue.main.async {
//                self.sortedLocations = posts
//                    .filter { $0.coordinate.latitude != 0 && $0.coordinate.longitude != 0 }
//                    .map {
//                        Location(name: $0.title.isEmpty ? "Пост" : $0.title,
//                                 coordinate: $0.coordinate)
//                    }
//
//                self.calculateRouteBetweenLocations()
//            }
//        }.resume()
//    }
//
//}
//
//extension MKPolyline {
//    var coordinates: [CLLocationCoordinate2D] {
//        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: self.pointCount)
//        self.getCoordinates(&coords, range: NSRange(location: 0, length: self.pointCount))
//        return coords
//    }
//}
//
//struct PostLocation: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//    let date: Date
//}
