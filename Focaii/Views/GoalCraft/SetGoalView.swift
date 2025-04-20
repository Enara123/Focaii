//
//  SetGoalView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-18.
//

import SwiftUI

struct SetGoalView: View {
    @State private var goalName: String = ""
    @State private var deadline: String = ""
    @State private var milestone1: String = ""
    @State private var milestone2: String = ""
    @State private var milestone3: String = ""
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 4) {
                Text("Break it Down")
                    .font(.system(size: 20, weight: .heavy))
                Text("Break milestones to tasks")
            }
            RectangleStepIndicator(totalSteps: 3, currentStep: 0)
            
            // Goal Name
            VStack(alignment: .leading, spacing: 10) {
                Text("Goal Name")
                    .font(.headline)
                TextField("e.g. Score above 80% for final exam", text: $goalName)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
            
            // Deadline
            VStack(alignment: .leading, spacing: 10) {
                Text("Deadline")
                    .font(.headline)
                Text("By when do you want to achieve this goal?")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                TextField("e.g. 02/04/25", text: $deadline)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
            
            // Milestones
            VStack(alignment: .leading, spacing: 10) {
                Text("Milestones")
                    .font(.headline)
                Text("What are some major checkpoints to achieve this goal?")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                TextField("e.g. Study all chapters", text: $milestone1)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                TextField("e.g. Practice with question papers", text: $milestone2)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                TextField("e.g. Revision", text: $milestone3)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1))
            }
            
            NavigationLink(destination: SetTasksView()) {
                Text("Next")
                    .frame(maxWidth: .infinity, maxHeight: 45)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.accent, lineWidth: 2))
                    .foregroundColor(Color.accent)
                    .padding(.top, 15)
            }
        }
        .padding()
    }
}

