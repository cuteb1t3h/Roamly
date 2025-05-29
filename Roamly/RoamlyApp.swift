//
//  RoamlyApp.swift
//  Roamly
//
//  Created by Настя on 06.04.2025.
//

import SwiftUI

@main
struct RoamlyApp: App {
    @StateObject private var authManager = AuthManager()
    @StateObject private var postManager = PostManager()

    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                MainTabView()
                    .environmentObject(authManager)
            } else {
                AuthView()
                    .environmentObject(authManager)
                    .environmentObject(postManager)
            }
        }
    }

}
