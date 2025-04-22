//
//  FocaiiApp.swift
//  Focaii
//
//  Created by Siluni 025 on 2025-03-25.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import UserNotifications

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
                .onAppear {
                    requestNotificationPermission()
                }
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }
    
}
