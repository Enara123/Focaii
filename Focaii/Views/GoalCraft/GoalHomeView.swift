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
                .accessibilityLabel("Goal Craft")
            Text("Set up a new guided goal")
                .padding(.bottom, 20)
            
            // Set a Goal
            NavigationLink(destination: SetGoalView(goalDraft: GoalModel())) {
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
            .accessibilityLabel("Set a goal")
            .accessibilityHint("Tap to go to set a goal.")
            
            // Goals in Progress
            NavigationLink(destination: GoalsInProgressView()) {
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
            .accessibilityLabel("Goals In progress")
            .accessibilityHint("Tap to go to view goals in progress.")
            
            // Completed Goals
            NavigationLink(destination: CompleteGoalsView()) {
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
            .accessibilityLabel("Completed Goals")
            .accessibilityHint("Tap to go to completed goal.")
            
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
