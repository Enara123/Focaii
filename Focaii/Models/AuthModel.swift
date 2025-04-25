//
//  AuthModel.swift
//  Focaii
//
//  Created by Siluni on 2025-04-01.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthModel: ObservableObject {
    @Published var user: User?
    @Published var isLoggedIn = false
    
    private let db = Firestore.firestore()
    
    init() {
        self.user = Auth.auth().currentUser
        self.isLoggedIn = self.user != nil
        
        // Listen for auth state changes
        _ = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            DispatchQueue.main.async {
                self?.user = user
                self?.isLoggedIn = user != nil
                print("Auth state changed. Updated self.user to: \(String(describing: user?.email))")
            }
        }
    }
    
    
    func signUp(username: String, email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                // Handle signup error
                print("SignUp Error: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            if let user = result?.user {
                // Save the email mapped to the username in Firestore
                self.db.collection("usernames").document(username).setData([
                    "email": email
                ]) { dbError in
                    DispatchQueue.main.async {
                        self.user = user
                        self.isLoggedIn = true
                    }
                    
                    if let dbError = dbError {
                        print("Firestore Error: \(dbError.localizedDescription)")
                        completion(dbError)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func login(username: String, password: String, completion: @escaping (Error?) -> Void) {
        let docRef = db.collection("usernames").document(username)
        docRef.getDocument { document, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let document = document, document.exists else {
                completion(NSError(domain: "AuthManager", code: 2, userInfo: [NSLocalizedDescriptionKey: "Username does not exist."]))
                return
            }
            
            guard let email = document.get("email") as? String else {
                completion(NSError(domain: "AuthManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Email not found for username."]))
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password) { result, authError in
                if let error = authError {
                    completion(error)
                } else {
                    DispatchQueue.main.async {
                        self.user = result?.user
                        self.isLoggedIn = true
                        print("User Logged is: \(String(describing: self.user))")
                        
                        if let userID = result?.user.uid {
                            let context = PersistenceController.shared.container.viewContext
                            let user = Users(context: context)
                            user.id = userID
                            user.username = username
                            
                            do {
                                try context.save()
                                print("User saved to Core Data")
                            } catch {
                                print("Failed to save user: \(error)")
                            }
                        }
                        
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.isLoggedIn = false
            print("Successfully logged out.")
        } catch let signOutError {
            print("Sign-out error: \(signOutError.localizedDescription)")
        }
    }
    
}
