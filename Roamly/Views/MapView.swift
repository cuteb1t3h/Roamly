//
//  MapView.swift
//  Roamly
//
//  Created by Настя on 06.04.2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var viewModel = MapViewModel()

    var body: some View {
        Map(position: $viewModel.cameraPosition) {
            // Линия маршрута
            if viewModel.routeCoordinates.count > 1 {
                MapPolyline(coordinates: viewModel.routeCoordinates)
                    .stroke(Color(red: 0.26, green: 0.29, blue: 0.72), lineWidth: 3)
            }

//             Метки с аватарками
            ForEach(viewModel.sortedLocations) { location in
                Annotation(location.name, coordinate: location.coordinate) {
                    if let avatar = viewModel.userAvatar {
                        Image(uiImage: avatar)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(red: 0.26, green: 0.29, blue: 0.72), lineWidth: 3))
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.loadLocationsFromPosts()
//            viewModel.loadUserAvatar(userID: 1)
            viewModel.calculateRouteBetweenLocations()
        }
    }
}

#Preview {
    MapView()
}
