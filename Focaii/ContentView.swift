//
//  ContentView.swift
//  Focaii
//
//  Created by Siluni 025 on 2025-03-25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authModel = AuthModel()
    
    var body: some View {
        if authModel.user != nil {
            TabBarView()
        } else {
            LoginView(authModel: authModel)
        }
        
    }
}

#Preview {
    ContentView()
}
