//
//  ProfileView.swift
//  SUI
//
//  Created by Эля Корельская on 29.05.2023.
//

import SwiftUI

struct ProfileView: View {
    @State private var login = ""
    @State private var password = ""
    var body: some View {
        VStack {
            Image("logo")
            // изменить размер
                .resizable()
            // подогнать изображение
                .aspectRatio(contentMode: .fit)
            // размер изображения
                .frame(width: 100, height: 100)
            // разделитель до стека
            Spacer()
                .frame(height: 120)
            VStack {
                
                TextField(" Email or phone", text: $login)
                    .modifier(AuthField())
                // высота поля с надписью
                    .padding(.top, 15)
                // разделитель
                Divider()
                // цвет разделителя
                    //.frame(height: 1)
                    .background(Color.gray)
                SecureField(" Password", text: $password)
                    .modifier(AuthField())
                // высота поля с надписью
                    .padding(.bottom, 15)
            }
            // внутренний цвет стека
            .background(Color.init(.systemGray6))
            // обрамление стека
            .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
            )
            .cornerRadius(10)
            Button(action: {
                print("button action")
            }, label: {
                Text("Log in")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .regular, design: .default))
            })
            .frame(minWidth: nil, idealWidth: nil, maxWidth: .infinity, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .center)
            .background(
            Image("blue_pixel")
                .resizable()
            )
            .cornerRadius(10)
            .padding(.top, 10)
        }
        .padding(.horizontal, 16)
        }
        
}

struct AuthField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.init(.systemGray6))
            .font(.system(size: 16, weight: .regular, design: .default))
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
