//
//  FocaiiApp.swift
//  Focaii
//
//  Created by Siluni 025 on 2025-03-25.
//

import SwiftUI
import Firebase

@main
struct FocaiiApp: App {
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
