import SwiftUI
import Combine

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool {
        didSet {
            UserDefaults.standard.set(isAuthenticated, forKey: "isAuthenticated")
        }
    }

    init() {
        self.isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
    }

    func logIn() {
        isAuthenticated = true
    }

    func logOut() {
        isAuthenticated = false
    }
}
