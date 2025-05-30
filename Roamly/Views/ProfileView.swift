//
//  ProfileView.swift
//  Roamly
//
//  Created by Настя on 09.04.2025.
//

import SwiftUI
import _MapKit_SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: UserSession
    @EnvironmentObject var authManager: AuthManager
    @StateObject var postManager = PostManager()
    @StateObject var userManager = UserManager()
    @State private var isMenuOpen = false
    @State private var selectedImageData: Data? = nil
    @State private var showFullScreenImage = false
    
    var body: some View {
        ZStack {
            // Основной экран
            NavigationStack {
                ScrollView {
                    VStack {
                        // Аватар
                        if let avatarData = Data(base64Encoded: userManager.user?.avatar ?? ""),
                           let uiImage = UIImage(data: avatarData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(red: 0.26, green: 0.29, blue: 0.72), lineWidth: 3))
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                        }
                        // Никнейм
                        Text("\(userManager.user?.username ?? "")")
                            .font(Font.custom("Poppins", size: 30).weight(.bold))
                            .padding(.top, 20)
                        
                        // Описание профиля
                        Text("\(userManager.user?.description ?? "")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        
                        Divider()
                            .padding(.vertical, 20)
                        
                        // Статистика
                        HStack(spacing: 40) {
                            VStack {
                                Text("\(postManager.posts.count)")
                                    .font(.title2)
                                    .bold()
                                Text("Путешествий")
                                    .font(.caption)
                            }
                            
                            VStack {
                                Text("\(userManager.user?.subscribers ?? 0)")
                                    .font(.title2)
                                    .bold()
                                Text("Подписчиков")
                                    .font(.caption)
                            }
                            
                            VStack {
                                Text("\(userManager.user?.subscribes ?? 0)")
                                    .font(.title2)
                                    .bold()
                                Text("Подписок")
                                    .font(.caption)
                            }
                        }
                        .padding(.bottom, 20)
                        
                        Divider()
                        NavigationLink(destination: CreatePostView(postManager: postManager)) {
                            Text("Записать путешествие")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.26, green: 0.29, blue: 0.72))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        // Список постов
                        VStack(spacing: 20) {
                            ForEach(postManager.posts) { post in
                                VStack(alignment: .leading, spacing: 8) {
                                    // Никнейм и локация
                                    HStack {
                                        if let avatarData = Data(base64Encoded: userManager.user?.avatar ?? ""),
                                           let uiImage = UIImage(data: avatarData) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                                .clipShape(Circle())
                                                .overlay(Circle().stroke(Color(red: 0.26, green: 0.29, blue: 0.72), lineWidth: 3))
                                        } else {
                                            Image(systemName: "person.crop.circle.fill")
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            Text(post.username)
                                                .font(.subheadline).bold()
                                            if post.coordinate.latitude != 0 && post.coordinate.longitude != 0 {
                                                Text("Москва") // или post.locationName
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(.horizontal, 8)
                                    
                                    // Карусель фотографий
                                    TabView {
                                        ForEach(post.images, id: \.self) { imageString in
                                            if let imageData = Data(base64Encoded: imageString),
                                               let uiImage = UIImage(data: imageData) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(height: 300)
                                                    .clipped()
                                                    .onTapGesture {
                                                        withAnimation {
                                                            selectedImageData = imageData
                                                            showFullScreenImage = true
                                                        }
                                                    }
                                            } else {
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 300)
                                                    .foregroundColor(.gray)
                                                    .background(Color.gray.opacity(0.1))
                                            }
                                        }
                                    }
                                    .frame(height: 300)
                                    .tabViewStyle(PageTabViewStyle())
                                    .cornerRadius(10)
                                    
                                    // Описание
                                    if !post.title.isEmpty {
                                        Text(post.title)
                                            .font(.headline)
                                    } else {
                                        Text("Установить статус")
                                            .font(.headline)
                                    }
                                    
                                    // Дата
                                    //                                    if let date = post.createdAt {
                                    //                                        Text(date.formatted(.dateTime.day().month().year()))
                                    //                                            .font(.caption)
                                    //                                            .foregroundColor(.gray)
                                    //                                    }
                                    
                                    //                                     Лайки и комментарии
                                    HStack(spacing: 16) {
                                        HStack(spacing: 4) {
                                            Image(systemName: "heart")
                                            Text("\(post.likes)")
                                        }
                                        HStack(spacing: 4) {
                                            Image(systemName: "bubble.right")
                                            Text("Комментарии")
                                        }
                                    }
                                    .font(.subheadline)
                                    .padding(.top, 4)
                                    .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(15)
                                .shadow(radius: 1)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                withAnimation {
                                    isMenuOpen.toggle()
                                }
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .font(.title)
                                    .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                            }
                        }
                    }
                    .navigationTitle("Профиль")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            // Затемнение фона при открытом меню
            if isMenuOpen {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen = false
                        }
                    }
            }
            
            // Боковое меню
            if isMenuOpen {
                GeometryReader { geometry in
                    VStack(alignment: .leading) {
                        Button("Редактировать профиль") {
                            print("Редактировать профиль")
                        }
                        .padding()
                        .foregroundColor(.white)
                        
                        Button("Выход") {
                            authManager.logOut()
                        }
                        .padding()
                        .foregroundColor(.red)
                        
                        Spacer()
                    }
                    .frame(width: 250)
                    .background(Color(red: 0.26, green: 0.29, blue: 0.72))
                    .cornerRadius(15)
                    .offset(x: isMenuOpen ? 0 : -geometry.size.width)
                    .animation(.easeInOut(duration: 0.3), value: isMenuOpen)
                }
                .transition(.move(edge: .leading))
            }
        }
        .onAppear {
            // Загружаем посты
            if let id = session.userID {
                postManager.fetchPosts(userID: id)
                userManager.fetchUser(userID: id)
            }
        }
        .overlay(
            Group {
                if let data = selectedImageData, let uiImage = UIImage(data: data), showFullScreenImage {
                    ZStack {
                        Color.black
                            .opacity(0.9)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    showFullScreenImage = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    selectedImageData = nil
                                }
                            }
                        
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .transition(.scale.combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.3), value: showFullScreenImage)
                    }
                }
            }
        )
    }
}

#Preview {
    ProfileView()
}
