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
            }

            NavigationStack {
                FocusTimeView()
            }
            .tabItem {
                Image(systemName: "clock")
                Text("Focus Time")
            }

            NavigationStack {
//                ProgressHubView()
            }
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
