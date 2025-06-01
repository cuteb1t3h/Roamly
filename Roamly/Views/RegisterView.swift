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
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @Environment(\.dismiss) var dismiss
    
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
                
                Group{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 310, height: 449)
                        .background(Color(red: 0.92, green: 0.92, blue: 1))
                        .cornerRadius(45)
                        .offset(x: 0, y: 90)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 60, height: 25)
                        .background(Color(red: 0.92, green: 0.92, blue: 1))
                        .cornerRadius(255)
                        .offset(x: -150, y: 210)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 60, height: 25)
                        .background(.white)
                        .cornerRadius(255)
                        .offset(x: -155, y: 235)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 60, height: 25)
                        .background(Color(red: 0.92, green: 0.92, blue: 1))
                        .cornerRadius(255)
                        .offset(x: -137, y: 260)
                    Ellipse()
                        .foregroundColor(Color(red: 0.92, green: 0.92, blue: 1))
                        .frame(width: 22, height: 22)
                        .background(.clear)
                        .offset(x: -184, y: 260)
                }
                Group {
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .font(Font.custom("Poppins", size: 18))
                        .padding()
                        .frame(width: 240, height: 50)
                        .background(Color.white)
                        .cornerRadius(255)
                        .offset(x: 0, y: -40)
                
                    SecureField("Пароль", text: $password)
                        .font(Font.custom("Poppins", size: 18))
                        .padding()
                        .frame(width: 240, height: 50)
                        .background(Color.white)
                        .cornerRadius(255)
                        .offset(x: 0, y: 20)
                    
                    SecureField("Повторите пароль", text: $confirmPassword)
                        .font(Font.custom("Poppins", size: 18))
                        .padding()
                        .frame(width: 240, height: 50)
                        .background(Color.white)
                        .cornerRadius(255)
                        .offset(x: 0, y: 80)
                    
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 240, height: 50)
                        .background(Color(red: 0.26, green: 0.29, blue: 0.72))
                        .cornerRadius(255)
                        .offset(x: 0, y: 160)
                    Button(action: register) {
                        Text("Зарегистрироваться")
                            .font(Font.custom("Poppins", size: 18))
                            .foregroundColor(.white)
                            .offset(x: 0, y: 160)
                    }
                }
                Text("Уже есть аккаунт?")
                    .font(Font.custom("Poppins", size: 17))
                    .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.39))
                    .offset(x: 0, y: 220)
                Button("Войти") {
                    dismiss()
                }
                .font(Font.custom("Poppins", size: 17))
                .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
                .offset(x: 0, y: 245)
            }
        }
    }
    
    private func register() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Пожалуйста, заполните все поля"
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Пароли не совпадают"
            return
        }
        
        errorMessage = nil
        
        let baseURL = "http://192.168.31.170:8080/register"
        guard var components = URLComponents(string: baseURL) else {
            errorMessage = "Неверный URL"
            return
        } 
        
        components.queryItems = [
            URLQueryItem(name: "email", value: email),
            URLQueryItem(name: "password", value: password)
        ]
        
        guard let url = components.url else {
            errorMessage = "Не удалось сформировать запрос"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = "Ошибка запроса: \(error.localizedDescription)"
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    errorMessage = "Некорректный ответ сервера"
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    dismiss()
                } else {
                    if let data = data, let serverMessage = String(data: data, encoding: .utf8) {
                        errorMessage = "Ошибка: \(serverMessage)"
                    } else {
                        errorMessage = "Ошибка регистрации (\(httpResponse.statusCode))"
                    }
                }
            }
        }.resume()
    }
}

