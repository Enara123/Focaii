//
//  HomeView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-17.
//

import SwiftUI

struct GoalHomeView: View {
    var body: some View {
        VStack {
            Text("Goal Craft")
                .font(.system(size: 20, weight: .heavy))
            Text("Set up a new guided goal")
                .padding(.bottom, 20)
            
            // Set a Goal
            NavigationLink(destination: Text("Set a goal")) {
                HStack {
                    Image("Goal")
                        .frame(width: 70, height: 70)
                        .background(Color.BG_2)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text("Set a goal")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(Color.primary)
                            .padding(.bottom, 1)
                        Text("Let's set a SMART goal")
                            .font(.system(size: 15))
                            .foregroundColor(Color.primary)
                    }
                    .padding(.leading, 10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
            }
            .padding(.bottom, 10)
            
            // Goals in Progress
            NavigationLink(destination: Text("Goals in Progress")) {
                HStack {
                    Image("InProgress")
                        .frame(width: 70, height: 70)
                        .background(Color.BG_2)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text("Goals in Progress")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(Color.primary)
                            .padding(.bottom, 1)
                        Text("All goals you are working on")
                            .font(.system(size: 15))
                            .foregroundColor(Color.primary)
                    }
                    .padding(.leading, 10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
            }
            .padding(.bottom, 10)
            
            // Completed Goals
            NavigationLink(destination: Text("Completed Goals")) {
                HStack {
                    Image("DoneGoals")
                        .frame(width: 70, height: 70)
                        .background(Color.BG_2)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text("Completed Goals")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(Color.primary)
                            .padding(.bottom, 1)
                        Text("Take look at your achieved goals")
                            .font(.system(size: 15))
                            .foregroundColor(Color.primary)
                    }
                    .padding(.leading, 10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
            }
            .padding(.bottom, 10)
            
        }
        .padding()
        Spacer()
    }
}

#Preview {
    NavigationStack {
        GoalHomeView()
    }
}
