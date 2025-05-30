//
//  UserSession.swift
//  Roamly
//
//  Created by Настя on 29.05.2025.
//

import SwiftUI

class UserSession: ObservableObject {
    @Published var userID: Int? {
        didSet {
            if let userID = userID {
                UserDefaults.standard.set(userID, forKey: "loggedInUserID")
            } else {
                UserDefaults.standard.removeObject(forKey: "loggedInUserID")
            }
        }
    }
    
    init() {
        self.userID = UserDefaults.standard.integer(forKey: "loggedInUserID")
        if self.userID == 0 {
            self.userID = nil
        }
    }
}
