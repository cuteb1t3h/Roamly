//
//  MapViewModel.swift
//  Roamly
//
//  Created by Настя on 06.04.2025.
//

import Foundation
import MapKit
import _MapKit_SwiftUI

class MapViewModel: ObservableObject {
    @Published var routeCoordinates: [CLLocationCoordinate2D] = []
    @Published var cameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.0, longitude: 15.0),
                           span: MKCoordinateSpan(latitudeDelta: 20.0, longitudeDelta: 20.0))
    )
    
    @Published var locations: [PostLocation] = []
    @Published var userAvatar: UIImage?

    var sortedLocations: [PostLocation] {
        locations.sorted { $0.date < $1.date }
    }

    func loadLocationsFromPosts() {
        // Здесь можно загрузить реальные посты из модели
        locations = [
            PostLocation(name: "Кельн", coordinate: CLLocationCoordinate2D(latitude: 50.9333, longitude:  6.95), date: Date(timeIntervalSinceNow: -86400 * 5)),
            PostLocation(name: "София", coordinate: CLLocationCoordinate2D(latitude: 42.697838, longitude: 23.314498), date: Date(timeIntervalSinceNow: -86400 * 4)),
            PostLocation(name: "Кисловодск", coordinate: CLLocationCoordinate2D(latitude: 43.9133, longitude: 42.7208), date: Date(timeIntervalSinceNow: -86400 * 4)),
//            PostLocation(name: "Москва", coordinate: CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173), date: Date(timeIntervalSinceNow: -86400 * 3)),
        ]
    }
    
    func calculateRouteBetweenLocations() {
        routeCoordinates = []
        let sorted = sortedLocations
        guard sorted.count > 1 else { return }

        let group = DispatchGroup()

        for i in 0..<sorted.count - 1 {
            let source = MKMapItem(placemark: MKPlacemark(coordinate: sorted[i].coordinate))
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: sorted[i + 1].coordinate))

            let request = MKDirections.Request()
            request.source = source
            request.destination = destination
            request.transportType = .automobile

            let directions = MKDirections(request: request)

            group.enter()
            directions.calculate { response, error in
                defer { group.leave() }
                guard let route = response?.routes.first else { return }

                self.routeCoordinates.append(contentsOf: route.polyline.coordinates)
            }
        }

        group.notify(queue: .main) {
            // Когда все маршруты готовы — обновится карта
            self.objectWillChange.send()
        }
    }

//    func loadUserAvatar(userID: Int) {
//        // Загрузка аватарки пользователя
//        if let data = try? Data(contentsOf: URL(string: "https://192.168.0.106:8080/user/\(userID)/avatar")!),
//           let image = UIImage(data: data) {
//            self.userAvatar = image
//        }
//    }
}

extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: self.pointCount)
        self.getCoordinates(&coords, range: NSRange(location: 0, length: self.pointCount))
        return coords
    }
}

struct PostLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let date: Date
}

