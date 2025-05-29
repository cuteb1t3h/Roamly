//
//  AuthView.swift
//  Roamly
//
//  Created by Настя on 06.04.2025.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var email = ""
    @State private var password = ""
    @State private var showRegister = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(systemName: "location.north.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                    .offset(x: -80, y:-305)
                Text("Roamly")
                    .font(Font.custom("Poppins", size: 43).weight(.medium))
                    .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                    .offset(x: 36.50, y: -305.50)
                Text("Твое путешествие начинается здесь")
                    .font(Font.custom("Poppins", size: 24).weight(.medium))
                    .foregroundColor(.black)
                    .offset(x: -4, y:-189)
                Text("здесь")
                    .font(Font.custom("Poppins", size: 24).weight(.medium))
                    .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                    .offset(x: 58, y:-175)
                Group {
                    //фон регистрации
                    Group{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 449)
                            .background(Color(red: 0.92, green: 0.92, blue: 1))
                            .cornerRadius(45)
                            .offset(x: 0, y: 93.50)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 60.06, height: 24.99)
                            .background(Color(red: 0.92, green: 0.92, blue: 1))
                            .cornerRadius(255)
                            .offset(x: -149.56, y: 211.45)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 60.06, height: 24.99)
                            .background(.white)
                            .cornerRadius(255)
                            .offset(x: -152.74, y: 235)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 60.06, height: 24.99)
                            .background(Color(red: 0.92, green: 0.92, blue: 1))
                            .cornerRadius(255)
                            .offset(x: -134.14, y: 260)
                        Ellipse()
                            .foregroundColor(Color(red: 0.92, green: 0.92, blue: 1))
                            .frame(width: 22, height: 22)
                            .background(.clear)
                            .offset(x: -184, y: 260)
                    }
                    //плашка регистрации
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 242.24, height: 47.03)
                        .background(.white)
                        .cornerRadius(255)
                        .offset(x: -0.27, y: -41.35)
                    TextField("Логин", text: $email)
                        .font(Font.custom("Poppins", size: 18))
                        .padding()
                        .frame(width: 242.24, height: 47.03)
                        .background(Color.white)
                        .cornerRadius(255)
                        .offset(y: -41.35)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 242.24, height: 47.03)
                        .background(.white)
                        .cornerRadius(255)
                        .offset(x: 0.80, y: 18.18)
                    SecureField("Пароль", text: $password)
                        .font(Font.custom("Poppins", size: 18))
                        .padding()
                        .frame(width: 242.24, height: 47.03)
                        .background(Color.white)
                        .cornerRadius(255)
                        .offset(y: 18.18)
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                            .offset(y: 60)
                    }
                    Rectangle()
                        .frame(width: 242.24, height: 47.03)
                        .background(Color(red: 0.26, green: 0.29, blue: 0.72))
                        .cornerRadius(255)
                        .offset(y: 90.93)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 242.24, height: 47.03)
                        .background(Color(red: 0.26, green: 0.29, blue: 0.72))
                        .cornerRadius(255)
                        .offset(x: -0.27, y: 90.93)
                    Button("Войти") {
                        guard !email.isEmpty, !password.isEmpty else {
                            errorMessage = "Пожалуйста, заполните все поля"
                            return
                        }
                        login(email: email, password: password) { success in
                            DispatchQueue.main.async {
                                if success {
                                    authManager.logIn()
                                    email = ""
                                    password = ""
                                    errorMessage = nil
                                } else {
                                    errorMessage = "Не удалось авторизоваться"
                                }
                            }
                        }
                    }
                    .font(Font.custom("Poppins", size: 18))
                    .foregroundColor(.white)
                    .offset(y: 90.93)
                    Text("ИЛИ")
                        .font(Font.custom("Poppins", size: 14))
                        .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.39))
                        .offset(x: 1.54, y: 140.14)
                    Button("Войти через Яндекс") {}
                        .font(Font.custom("Poppins", size: 17))
                        .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                        .offset(y: 184.25)
                    Text("У Вас еще нет аккаунта?")
                        .font(Font.custom("Poppins", size: 14))
                        .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.39))
                        .offset(x: 5, y: 265)
                    Button("Зарегистрироваться"){
                        showRegister = true
                    }
                    .font(Font.custom("Poppins", size: 14))
                    .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                    .offset(x: 5, y: 285)
                }
                .navigationDestination(isPresented: $showRegister) {
                    RegisterView()
                }
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://192.168.0.105:8080/auth/login") else {
            completion(false)
            return
        }
        
        let payload: [String: String] = [
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(payload)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(false)
                return
            }
            completion(httpResponse.statusCode == 200)
        }.resume()
    }
}
