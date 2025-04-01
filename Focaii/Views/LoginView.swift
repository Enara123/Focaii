//
//  LoginView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-01.
//
import SwiftUI

struct LoginView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    
    public struct CustomTextFieldStyle : TextFieldStyle {
            public func _body(configuration: TextField<Self._Label>) -> some View {
                configuration
                    .font(.body)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.primary.opacity(0.2), lineWidth: 1)
                            .shadow( color:.black.opacity(0.9) , radius:2, x:2, y:2)
                            .background(.white))
            }
        }
    
    var body: some View {
        VStack {
            Image("Logo")
                .padding(.bottom, 5)
            Text("Let's get you in!")
                .padding(.bottom, 40)
            
            TextField(
                "Username",
                text: $username
            )
            .padding(.bottom, 10)
            
            TextField(
                "Password",
                text: $password
            )
            
            HStack {
                Spacer()
                Button(action: {
                    print("Button tapped!")
                }) {
                    
                    Text("Forgot password?")
                        .font(.callout)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            Button(action: {
                print("Button tapped!")
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity, maxHeight: 45)
                    .background(Color.accent)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.top, 15)
                    .shadow( color:.black.opacity(0.7) , radius:2, x:2, y:2)
            }
            
            HStack {
                Text("Don't have an account?")
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Button(action: {
                    print("Button tapped!")
                }) {
                    Text("Sign up")
                        .font(.callout)
                }
            }
            .padding(.top, 5)
        }
        .textFieldStyle(CustomTextFieldStyle())
        .padding(20)
    }
}

#Preview {
    LoginView()
}
