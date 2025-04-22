//
//  Dashboard.swift
//  Focaii
//
//  Created by Siluni on 2025-04-01.
//
import SwiftUI

struct Dashboard: View {
    @Environment(\.colorScheme) private var systemColorScheme
    @EnvironmentObject var auth: AuthModel
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        entity: Users.entity(),
        sortDescriptors: []
    ) var users: FetchedResults<Users>
    
    @State private var appColorScheme: ColorScheme = .light
    @State private var isOn: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image("User")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.leading, 20)
                
                Button("Logout", role: .destructive){
                    auth.logout()
                }
                .foregroundColor(.blue)
                
                Spacer()
                
                HStack() {
                    Image(systemName: isOn ? "moon.fill" : "sun.max.fill")
                        .foregroundColor(isOn ? .yellow : .orange)
                    
                    Toggle("", isOn: $isOn)
                        .labelsHidden()
                        .tint(Color.accent)
                        .scaleEffect(0.8)
                        .padding(.trailing, 20)
                }
            }
            if let user = users.first {
                Text("Welcome \(user.username ?? "Guest")!")
                    .font(.system(size: 20, weight: .heavy))
                    .padding(.bottom, 1)
            } else {
                Text("Loading user...")
            }
            
            Text("Let's get to work!")
            Image("Main")
            
            HStack(spacing:40) {
                NavigationLink(destination: FocusTimeView()) {
                    VStack() {
                        Image("FocusTime")
                            .frame(width: 70, height: 70)
                            .background(Color.BG_1)
                            .cornerRadius(8)
                        Text("Focus Time")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.primary)
                    }
                }
                
                NavigationLink(destination: GoalHomeView()) {
                    VStack() {
                        Image("Progress")
                            .frame(width: 70, height: 70)
                            .background(Color.BG_1)
                            .cornerRadius(8)
                        Text("Progress Hub")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.primary)
                    }
                }
                NavigationLink(destination: GoalHomeView()) {
                    VStack() {
                        Image("Deep Focus")
                            .frame(width: 70, height: 70)
                            .background(Color.BG_1)
                            .cornerRadius(8)
                        Text("Deep Focus")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.primary)
                    }
                }
            }
            
            HStack(spacing:40) {
                NavigationLink(destination: GoalHomeView()) {
                    VStack() {
                        Image("Goal")
                            .frame(width: 70, height: 70)
                            .background(Color.BG_2)
                            .cornerRadius(8)
                        Text("Goal Craft")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.primary)
                    }
                }
                NavigationLink(destination: GoalHomeView()) {
                    VStack() {
                        Image("Mind Well")
                            .frame(width: 70, height: 70)
                            .background(Color.BG_2)
                            .cornerRadius(8)
                        Text("Mind Well")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.primary)
                    }
                }
            }
            .padding(.top, 20)
            Spacer()
            
        }.preferredColorScheme(appColorScheme)
            .onAppear() {
                switchAppearance()
            }.onChange(of: isOn) { oldValue, newValue in
                if newValue == false {
                    appColorScheme = .light
                    return
                }
                appColorScheme = .dark
            }
            .navigationBarBackButtonHidden(true)
    }
    
    func switchAppearance() {
        appColorScheme = systemColorScheme
        if appColorScheme == .light {
            isOn = false
            return
        }
        else {
            isOn = true
            return
        }
    }
}

#Preview {
    NavigationStack {
        Dashboard()
    }
}
