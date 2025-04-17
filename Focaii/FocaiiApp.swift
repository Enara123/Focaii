//
//  FocaiiApp.swift
//  Focaii
//
//  Created by Siluni 025 on 2025-03-25.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct FocaiiApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var authModel = AuthModel()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
