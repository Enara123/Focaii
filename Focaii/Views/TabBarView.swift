//
//  TabBarView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-09.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            Dashboard()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            LoginView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Focus Time")
                }

            SignupView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Progress Hub")
                }
        }
        .accentColor(Color.accent)
    }
}

#Preview {
    TabBarView()
}
