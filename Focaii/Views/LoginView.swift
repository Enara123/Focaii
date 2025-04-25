//
//  LoginView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-01.
//
import SwiftUI

struct LoginView: View {
    @ObservedObject var authModel: AuthModel
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    
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
        NavigationStack {
            VStack {
                Image("Logo")
                    .padding(.bottom, 5)
                Text("Let's get you in!")
                    .padding(.bottom, 40)
                
                //Login Form
                TextField("Username", text: $username).padding(.bottom, 10)
                    .accessibilityLabel("Enter username")
                SecureField("Password", text: $password)
                    .accessibilityLabel("Enter password")
                
                HStack {
                    Spacer()
                    Button(action: {
                        print("Button tapped!")
                    }) {
                        Text("Forgot password?")
                            .font(.callout)
                            .multilineTextAlignment(.trailing)
                            .padding(.bottom, 5)
                    }
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .accessibilityLabel(errorMessage)
                }
                
                Button(action: {
                    checkUserCredentials()
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity, maxHeight: 45)
                        .background(Color.accent)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                        .shadow(color: .black.opacity(0.7), radius: 2, x: 2, y: 2)
                        .accessibilityLabel("Login Button")
                        .accessibilityHint("Tap to login.")
                }

                HStack {
                    Text("Don't have an account?")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .accessibilityLabel("Don't have an account message")
                    
                    NavigationLink {
                        SignupView()
                    } label: {
                        Text("Sign up")
                            .font(.callout)
                    }
                    .accessibilityLabel("Sign up link")
                }
                .padding(.top, 5)
            }
            .textFieldStyle(CustomTextFieldStyle())
            .padding(20)
            
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Methods
    
    func checkUserCredentials() {
        if username.isEmpty || password.isEmpty {
            errorMessage = "Please enter both username and password."
        }
        else {
            authModel.login(username: username, password: password) { error in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    errorMessage = "Incorrect login credentials. Please try again."
                } else {
                    errorMessage = nil
                    print("Login successful")
                }
            }
        }
    }
}

