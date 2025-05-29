//
//  MainTabView.swift
//  Roamly
//
//  Created by Настя on 06.04.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Карта")
                }
            FeedView()
                .tabItem {
                    Image(systemName: "photo.on.rectangle")
                    Text("Лента")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Профиль")
                }
        }
    }
}
    
#Preview {
    MainTabView()
}
