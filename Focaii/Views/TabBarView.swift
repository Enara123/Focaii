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
            NavigationStack {
                Dashboard()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
                    .accessibilityLabel("Home tab")
            }

            NavigationStack {
                FocusTimeView()
            }
            .tabItem {
                Image(systemName: "clock")
                Text("Focus Time")
                    .accessibilityLabel("Focus Time tab. For quick access to focus time tracking.")
            }

            NavigationStack {
                ProgressHubView()
            }
            .tabItem {
                Image(systemName: "chart.bar")
                Text("Progress Hub")
                    .accessibilityLabel("Progress Hub tab. For quick access to see progress on goals.")
            }
        }
        .accentColor(Color.accent)
    }
}

#Preview {
    TabBarView()
}
