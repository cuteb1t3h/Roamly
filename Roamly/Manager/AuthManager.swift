import SwiftUI
import Combine

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool {
        didSet {
            UserDefaults.standard.set(isAuthenticated, forKey: "isAuthenticated")
        }
    }
    
    @Published var userID: Int {
        didSet {
            UserDefaults.standard.set(userID, forKey: "userID")
        }
    }

    init() {
        self.isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
        self.userID = UserDefaults.standard.integer(forKey: "userID")
    }

    func logIn(userID: Int) {
        self.userID = userID
        isAuthenticated = true
    }

    func logOut() {
        isAuthenticated = false
        userID = 0
    }
}
