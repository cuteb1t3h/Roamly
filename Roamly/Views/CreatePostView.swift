//
//  CreatePostView.swift
//  Roamly
//
//  Created by Настя on 19.05.2025.
//

import SwiftUI
import MapKit
import Combine

struct CreatePostView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var postManager: PostManager
    @State private var username: String = "any_kriz"
    @State private var locationName: String = ""
    @State private var description: String = ""
    @State private var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @State private var selectedImageNames: [String] = []
    @State private var likes: Int = 0
    
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Название места", text: $locationName)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                TextField("Описание", text: $description)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                Map(coordinateRegion: $mapRegion, showsUserLocation: true)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .onReceive(Just(mapRegion.center)) { newCenter in
                        coordinate = newCenter
                    }
                
                Button("Добавить изображение") {
                    // Логика добавления изображения (пока заглушка)
                    selectedImageNames.append("photo1")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 0.26, green: 0.29, blue: 0.72))
                .foregroundColor(.white)
                .cornerRadius(10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(selectedImageNames, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(8)
                        }
                    }
                }
                
                Button("Создать пост") {
                    let newPost = TravelPost(
                        username: username,
                        title: locationName,
                        coordinate: coordinate,
                        images: selectedImageNames,
                        likes: likes,
                        date: "2025-06-30"
                    )
                    postManager.addPost(newPost)
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 0.26, green: 0.29, blue: 0.72))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .navigationTitle("Новый пост")
        }
    }
}
