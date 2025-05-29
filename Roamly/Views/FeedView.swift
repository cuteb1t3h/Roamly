//
//  FeedView.swift
//  Roamly
//
//  Created by Настя on 06.04.2025.
//

import SwiftUI
import MapKit

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    @State private var selectedImage: String? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.posts) { post in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                                Text(post.username)
                                    .font(.headline)
                                Spacer()
                                Image(systemName: "ellipsis")
                            }
                            
                            Map(
                                position: .constant(
                                    .region(MKCoordinateRegion(
                                        center: post.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                    ))
                                )
                            )
                            .frame(height: 200)
                            .cornerRadius(10)
                            
                            HStack(spacing: 10) {
                                VStack(spacing: 10) {
                                    ForEach(post.images, id: \.self) { imageName in
                                        Image(imageName)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipped()
                                            .cornerRadius(8)
                                            .onTapGesture {
                                                selectedImage = imageName
                                            }
                                    }
                                }
                                .frame(width: 110)
                                
                                Spacer()
                            }

                            HStack {
                                Image(systemName: "heart")
                                Image(systemName: "bubble.right")
                                Text("Посмотреть комментарии")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
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
            .navigationTitle("Roamly")
        }
        .onAppear {
            viewModel.fetchFeedPosts(userID: 1)
        }
        .overlay(
            Group {
                if let imageName = selectedImage {
                    ZStack {
                        Color.black.opacity(0.8)
                            .ignoresSafeArea()
                            .onTapGesture {
                                selectedImage = nil
                            }
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                }
            }
        )
    }
}

#Preview {
    FeedView()
}
