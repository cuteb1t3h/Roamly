//
//  FeedView.swift
//  Roamly
//
//  Created by Настя on 06.04.2025.
//

import SwiftUI
import MapKit

struct FeedView: View {
    @EnvironmentObject var session: UserSession
    @StateObject var feedManager = FeedManager()
    @State private var selectedImage: String? = nil
    @State private var showFullScreenImage = false
    @State private var cityNames: [UUID: String] = [:]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(feedManager.posts) { post in
                        VStack(alignment: .leading, spacing: 10) {
                            // Никнейм и локация
                            HStack {
                                if let avatarData = Data(
                                    base64Encoded: post.avatar
                                ),
                                   let uiImage = UIImage(data: avatarData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(
                                                    Color(
                                                        red: 0.26,
                                                        green: 0.29,
                                                        blue: 0.72
                                                    ),
                                                    lineWidth: 3
                                                )
                                        )
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(
                                            Color(
                                                red: 0.26,
                                                green: 0.29,
                                                blue: 0.72
                                            )
                                        )
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(post.username)
                                        .font(.subheadline).bold()
                                    if post.coordinate.latitude != 0 && post.coordinate.longitude != 0 {
                                        Text(cityNames[post.id] ?? "Загрузка...")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .onAppear {
                                    if post.coordinate.latitude != 0 && post.coordinate.longitude != 0 && cityNames[post.id] == nil {
                                            feedManager.getCityName(from: post.coordinate) { city in
                                                if let city = city {
                                                    DispatchQueue.main.async {
                                                        cityNames[post.id] = city
                                                    }
                                                }
                                            }
                                        }
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 8)
                            
                            HStack(spacing: 10) {
                                Map(
                                    position: .constant(
                                        .region( MKCoordinateRegion(
                                            center: post.coordinate,
                                            span: MKCoordinateSpan(
                                                latitudeDelta: 0.1,
                                                longitudeDelta: 0.1)
                                        ))
                                    )
                                )
                                .frame(height: 200)
                                .cornerRadius(10)
                                
                                ScrollView(.vertical, showsIndicators: false){
                                    VStack(spacing: 10) {
                                        ForEach(
                                            post.images,
                                            id: \.self
                                        ) { imageName in
                                            if let imageData = Data(
                                                base64Encoded: imageName
                                            ),
                                               let uiImage = UIImage(
                                                data: imageData
                                               ) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(
                                                        width: 100,
                                                        height: 100
                                                    )
                                                    .clipped()
                                                    .cornerRadius(8)
                                                    .onTapGesture {
                                                        selectedImage = imageName
                                                    }
                                            }
                                        }
                                    }
                                }
                                .frame(height: 200)
                            }
//                            .padding(.horizontal)
                        
                            // Описание
                            if !post.title.isEmpty {
                                Text(post.title)
                                    .font(.headline)
                            }
                                        
                            // Лайки и комментарии
                            HStack(spacing: 16) {
                                HStack(spacing: 4) {
                                    Image(systemName: "heart")
                                    Text("\(post.likes)")
                                }
                                HStack(spacing: 4) {
                                    Image(
                                        systemName: "bubble.right"
                                    )
                                    Text("Комментарии")
                                }
                            }
                            .font(.subheadline)
                            .padding(.top, 4)
                            .foregroundColor(.gray)
                            .frame(width: 200)
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(15)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Traveler")
        }
        .onAppear {
            if let id = session.userID {
                feedManager.fetchFeedPosts(userID: id)
            }
        }
    }
}

#Preview {
    FeedView()
}
