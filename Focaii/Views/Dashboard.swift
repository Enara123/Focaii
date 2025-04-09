//
//  Dashboard.swift
//  Focaii
//
//  Created by Siluni on 2025-04-01.
//
import SwiftUI

struct Dashboard: View {
    @State private var isOn: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image("User")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.leading, 20)
//                Spacer()
                Toggle("", isOn: $isOn)
                    .padding(.trailing, 20)
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
                        Image("FocusTime")
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
                        Image("FocusTime")
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
                        Image("FocusTime")
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
                        Image("FocusTime")
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
            
        }
    }
}

#Preview {
    Dashboard()
}
