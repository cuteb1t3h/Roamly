//
//  RegisterView.swift
//  Roamly
//
//  Created by Настя on 01.05.2025.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var session: UserSession

    var body: some View {
        NavigationStack {
            ZStack {
                Image(systemName: "location.north.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                    .offset(x: 0, y:-305)
                Text("Регистрация")
                    .font(Font.custom("Poppins", size: 36).weight(.medium))
                    .foregroundColor(.black)
                    .offset(x: 0, y: -240)
                
                Group {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 310, height: 450)
                        .background(Color(red: 0.92, green: 0.92, blue: 1))
                        .cornerRadius(45)
                        .offset(x: 0, y: 70)
                    
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .font(Font.custom("Poppins", size: 18))
                        .padding()
                        .frame(width: 240, height: 50)
                        .background(Color.white)
                        .cornerRadius(255)
                        .offset(x: 0, y: -90)
                    
                    TextField("Username", text: $username)
                        .textInputAutocapitalization(.never)
                        .font(Font.custom("Poppins", size: 18))
                        .padding()
                        .frame(width: 240, height: 50)
                        .background(Color.white)
                        .cornerRadius(255)
                        .offset(x: 0, y: -25)
                    
                    SecureField("Пароль", text: $password)
                        .font(Font.custom("Poppins", size: 18))
                        .padding()
                        .frame(width: 240, height: 50)
                        .background(Color.white)
                        .cornerRadius(255)
                        .offset(x: 0, y: 40)
                    
                    SecureField("Повторите пароль", text: $confirmPassword)
                        .font(Font.custom("Poppins", size: 18))
                        .padding()
                        .frame(width: 240, height: 50)
                        .background(Color.white)
                        .cornerRadius(255)
                        .offset(x: 0, y: 105)
                    
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                            .offset(y: 190)
                    }
                    
                    Button(action: {
                        register(email: email, password: password, username: username)
                        {
                        userID in
                            DispatchQueue.main.async {
                                if let userID = userID {
                                    session.userID = userID
                                    authManager.logIn(userID: userID)
                                    email = ""
                                    password = ""
                                    username = ""
                                    confirmPassword = ""
                                    errorMessage = nil
                                } else {
                                    errorMessage = "Ура"
                                }
                            }
                        }
                    }) {
                        Text("Зарегистрироваться")
                            .font(Font.custom("Poppins", size: 18))
                            .foregroundColor(.white)
                            .frame(width: 240, height: 50)
                            .background(Color(red: 0.26, green: 0.29, blue: 0.72))
                            .cornerRadius(255)
                    }
                    .offset(x: 0, y: 185)
                }
                
                Text("Уже есть аккаунт?")
                    .font(Font.custom("Poppins", size: 17))
                    .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.39))
                    .offset(x: 0, y: 240)
                Button("Войти") {
                    dismiss()
                }
                .font(Font.custom("Poppins", size: 17))
                .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                .offset(x: 0, y: 265)
            }
        }
    }

    struct RegisterResponse: Decodable {
        let user_id: Int
    }

    func register(email: String, password: String, username: String, completion: @escaping (Int?) -> Void) {
        guard !email.isEmpty, !password.isEmpty, !username.isEmpty else {
            errorMessage = "Пожалуйста, заполните все поля"
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Пароли не совпадают"
            return
        }
        
        errorMessage = nil
        
        guard let url = URL(string: "http://192.168.31.170:8080/register") else {
            errorMessage = "Неверный URL"
            return
        }
        
        let payload: [String: String] = [
            "email": email,
            "password": password,
            "username": username
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(payload)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            if let decoded = try? JSONDecoder().decode(RegisterResponse.self, from: data) {
                completion(decoded.user_id)
            } else {
                if let string = String(data: data, encoding: .utf8) {
                    print("Ответ сервера: \(string)")
                }
                completion(nil)
            }
        }.resume()
    }
}

#Preview {
    RegisterView()
}
