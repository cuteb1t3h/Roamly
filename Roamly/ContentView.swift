//
//  ContentView.swift
//  Roamly
//
//  Created by Настя on 06.04.2025.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack() {
      Group {
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
          .background(Color(red: 0.92, green: 0.92, blue: 1))
          .cornerRadius(255)
          .offset(x: -134.14, y: 261.41)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 60.06, height: 24.99)
          .background(.white)
          .cornerRadius(255)
          .offset(x: -152.74, y: 236.44)
        Ellipse()
          .foregroundColor(.clear)
          .frame(width: 22, height: 22)
          .background(Color(red: 0.92, green: 0.92, blue: 1))
          .offset(x: -184, y: 260)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 242.24, height: 47.03)
          .background(.white)
          .cornerRadius(255)
          .offset(x: -0.27, y: -41.35)
        Text("Логин")
          .font(Font.custom("Poppins", size: 12))
          .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.39))
          .offset(x: -85.50, y: -40)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 242.24, height: 47.03)
          .background(.white)
          .cornerRadius(255)
          .offset(x: 0.80, y: 18.18)
        Text("Пароль")
          .font(Font.custom("Poppins", size: 12))
          .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.39))
          .offset(x: -81.19, y: 18.15)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 242.24, height: 47.03)
          .background(Color(red: 0.26, green: 0.29, blue: 0.72))
          .cornerRadius(255)
          .offset(x: -0.27, y: 90.93)
      }
        Group {
        Text("Войти")
          .font(Font.custom("Poppins", size: 12))
          .foregroundColor(.white)
          .offset(x: -5.11, y: 91)
        Text("ИЛИ")
          .font(Font.custom("Poppins", size: 12))
          .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.39))
          .offset(x: 1.54, y: 140.14)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 22, height: 22)
          .background(Color(red: 0.50, green: 0.23, blue: 0.27).opacity(0.50))
          .cornerRadius(8)
          .offset(x: 30, y: 183)
        Ellipse()
          .foregroundColor(.clear)
          .frame(width: 30, height: 27)
          .background(Color(red: 1, green: 1, blue: 1).opacity(0))
          .overlay(
            Ellipse()
              .inset(by: 0.50)
              .stroke(Color(red: 0.26, green: 0.29, blue: 0.72), lineWidth: 0.50)
          )
          .offset(x: 30, y: 182.50)
        Text("Войти через     ")
          .font(Font.custom("Poppins", size: 12))
          .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
          .offset(x: -13.34, y: 184.25)
        Text("Забыли пароль?")
          .font(Font.custom("Poppins", size: 12))
          .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.39))
          .offset(x: 5.69, y: 237.88)
        Text("У Вас еще нет аккаунта? Зарегестрироваться")
          .font(Font.custom("Poppins", size: 12))
          .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.39))
          .offset(x: 9.61, y: 273.91)
      }
        Group {
        Text("Traveler")
          .font(Font.custom("Poppins", size: 43).weight(.medium))
          .foregroundColor(Color(red: 0.26, green: 0.29, blue: 0.72))
          .offset(x: 36.50, y: -305.50)
        Text("Твое путешествие начинается здесь")
          .font(Font.custom("Poppins", size: 24).weight(.medium))
          .foregroundColor(.black)
          .offset(x: -4, y:-189)
        ZStack() {
          ZStack() {
            Text("9:41")
              .font(Font.custom("SF Pro Text", size: 17).weight(.semibold))
              .lineSpacing(22)
              .foregroundColor(.black)
              .offset(x: 0, y: 0.50)
          }
          .frame(width: 54, height: 21)
          .cornerRadius(24)
          .offset(x: -141, y: 1)
          ZStack() {

          }
          .frame(width: 27.40, height: 13)
          .offset(x: 154.70, y: 2)
        }
        .frame(width: 390, height: 47)
        .background(.white)
        .offset(x: 0, y: -398.50)
        ZStack() {
          Rectangle()
            .foregroundColor(.clear)
            .frame(width: 134, height: 5)
            .background(.black)
            .cornerRadius(100)
            .offset(x: 0, y: 6.50)
        }
        .frame(width: 390, height: 34)
        .background(.white)
        .offset(x: 0, y: 405)
        Ellipse()
          .foregroundColor(.clear)
          .frame(width: 60, height: 60)
          .background(Color(red: 0.26, green: 0.29, blue: 0.72))
          .offset(x: -101, y: -305)
        Ellipse()
          .foregroundColor(.clear)
          .frame(width: 50, height: 50)
          .background(Color(red: 1, green: 1, blue: 1))
          .offset(x: -101, y: -305)
      }
        Group {
        Ellipse()
          .foregroundColor(.clear)
          .frame(width: 4, height: 4)
          .background(Color(red: 0.93, green: 0.13, blue: 0.14))
          .offset(x: -80, y: -326)
        Ellipse()
          .foregroundColor(.clear)
          .frame(width: 20, height: 18)
          .background(Color(red: 0.26, green: 0.29, blue: 0.72))
          .offset(x: -101, y: -305)
        Ellipse()
          .foregroundColor(.clear)
          .frame(width: 16, height: 16)
          .background(.white)
          .offset(x: -101, y: -305)
        Ellipse()
          .foregroundColor(.clear)
          .frame(width: 14, height: 14)
          .background(Color(red: 0.26, green: 0.29, blue: 0.72))
          .offset(x: -101, y: -305)
      }
    }
    .frame(width: 390, height: 844)
    .background(.white)
    .cornerRadius(45);
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

#Preview {
    ContentView()
}
