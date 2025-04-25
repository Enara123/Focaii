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
    
    @State private var appColorScheme: ColorScheme = .light // Enable dark and light modes
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
                    .accessibilityLabel("Welcome \(user.username ?? "Guest")!")
            } else {
                Text("Loading user...")
            }
            
            Text("Let's get to work!")
                .accessibilityLabel("You are in the dashboard. Let's get to work!")
            Image("Main")
            
            // MARK: - App Features
            HStack(spacing:40) {
                NavigationLink(destination: FocusTimeView()) {
                    VStack {
                        Image("FocusTime")
                            .frame(width: 70, height: 70)
                            .background(Color.BG_1)
                            .cornerRadius(8)
                            .accessibilityLabel("Focus Time Icon")
                        
                        Text("Focus Time")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.primary)
                            .accessibilityLabel("Focus Time feature")
                            .accessibilityHint("Tap to go to the Focus Time feature.")
                    }
                    .accessibilityIdentifier("FocusTimeNavigationLink")
                }

                
                NavigationLink(destination: ProgressHubView()) {
                    VStack() {
                        Image("Progress")
                            .frame(width: 70, height: 70)
                            .background(Color.BG_1)
                            .cornerRadius(8)
                            .accessibilityLabel("Progress Hub Icon")
                        Text("Progress Hub")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.primary)
                            .accessibilityLabel("Progress Hub feature")
                            .accessibilityHint("Tap to go to the Progress Hub feature.")
                    }
                }
                NavigationLink(destination: DeepFocusView()) {
                    VStack() {
                        Image("Deep Focus")
                            .frame(width: 70, height: 70)
                            .background(Color.BG_1)
                            .cornerRadius(8)
                            .accessibilityLabel("Deep Focus Icon")
                        Text("Deep Focus")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.primary)
                            .accessibilityLabel("Deep Focus feature")
                            .accessibilityHint("Tap to go to the Deep Focus feature.")
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
                            .accessibilityLabel("Goal Craft Icon")
                        Text("Goal Craft")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.primary)
                            .accessibilityLabel("Goal Craft feature")
                            .accessibilityHint("Tap to go to the Goal Craft feature.")
                    }
                }
                NavigationLink(destination: Text("Oops! Nothing here yet...")) {
                    VStack() {
                        Image("Mind Well")
                            .frame(width: 70, height: 70)
                            .background(Color.BG_2)
                            .cornerRadius(8)
                            .accessibilityLabel("Mind Well Icon")
                        Text("Mind Well")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.primary)
                            .accessibilityLabel("Mind Well feature")
                            .accessibilityHint("Tap to go to the Mind Well feature.")
                    }
                }
            }
            .padding(.top, 20)
            Spacer()
        
            //Set App theme to match system theme
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
    
    // MARK: - Methods
    
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
