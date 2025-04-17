//
//  SignupView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-01.
//
import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authModel: AuthModel

    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var errorMessage: String? = nil
    @State var isAttempted: Bool = false

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
                Text("Sign up to join us!")
                    .padding(.bottom, 40)

                TextField("Username", text: $username)
                    .padding(.bottom, 10)
                if isAttempted && !Validator.isValidUsername(username) {
                    Text("Username must be 3–15 characters, alphanumeric or underscore.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                } else if isAttempted && !Validator.isUsernameAllowed(username) {
                    Text("This username is reserved. Please choose another.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                TextField("Email", text: $email)
                    .padding(.bottom, 10)
                if isAttempted && !Validator.isValidEmail(email) {
                    Text("Please enter a valid email.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                SecureField("Password", text: $password)
                    .padding(.bottom, 10)
                if isAttempted && !Validator.isStrongPassword(password) {
                    Text("Password must be at least 8 characters with a number or symbol.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                SecureField("Confirm Password", text: $confirmPassword)
                if isAttempted && !Validator.passwordsMatch(password, confirmPassword) {
                    Text("Passwords are not matching. Please check again.")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 5)
                }

                // Sign up button
                Button(action: {
                    isAttempted = true
                    if validateForm() {
                        registerNewUser()
                    }
                }) {
                    Text("Sign up")
                        .frame(maxWidth: .infinity, maxHeight: 45)
                        .background(Color.accent)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                        .shadow(color: .black.opacity(0.7), radius: 2, x: 2, y: 2)
                }

                HStack {
                    Text("Already have an account?")
                        .font(.callout)
                        .foregroundColor(.gray)

                    Button(action: {
                        dismiss()
                    }) {
                        Text("Login")
                            .font(.callout)
                    }
                }
                .frame(alignment: .center)
                .padding(.top, 5)
            }
            .textFieldStyle(CustomTextFieldStyle())
            .padding(20)
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Methods

    func validateForm() -> Bool {
        guard Validator.isValidUsername(username),
              Validator.isUsernameAllowed(username),
              Validator.isValidEmail(email),
              Validator.isStrongPassword(password),
              Validator.passwordsMatch(password, confirmPassword)
        else {
            return false
        }
        return true
    }

    func registerNewUser() {
        authModel.signUp(username: username, email: email, password: password) { error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                errorMessage = nil
                print("Signup successful")
            }
        }
    }
}

#Preview {
    SignupView()
        .environmentObject(AuthModel())
}
