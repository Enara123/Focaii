//
//  Dashboard.swift
//  Focaii
//
//  Created by Siluni on 2025-04-01.
//
import SwiftUI

struct Dashboard: View {
    @Environment(\.colorScheme) private var systemColorScheme
    
    @State private var appColorScheme: ColorScheme = .light
    @State private var isOn: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image("User")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.leading, 20)
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
            Text("Welcome Anne")
                .font(.system(size: 20, weight: .heavy))
                .padding(.bottom, 1)
            Text("Let's get to work!")
            Image("Main")
            
            HStack(spacing:40) {
                Button{
                    print("Focus time")
                } label: {
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
                Button{
                    print("Progress Hub")
                } label: {
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
                Button{
                    print("Deep Focus")
                } label: {
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
                Button{
                    print("Goal Craft")
                } label: {
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
                Button{
                    print("Mind Well")
                } label: {
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
    Dashboard()
}
