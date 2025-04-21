//
//  SetGoalView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-18.
//

import SwiftUI

struct SetGoalView: View {
    @ObservedObject var goalDraft: GoalModel
    @State private var shouldNavigate = false
    @State private var errorMessage: String? = nil
    
    var body: some View {
        ScrollView() {
            VStack(spacing: 15) {
                VStack(spacing: 4) {
                    Text("Set a goal")
                        .font(.system(size: 20, weight: .heavy))
                    Text("Let's set a SMART goal")
                }
                RectangleStepIndicator(totalSteps: 3, currentStep: 0)
                
                // Goal Name
                VStack(alignment: .leading, spacing: 10) {
                    Text("Goal Name")
                        .font(.headline)
                    TextField("e.g. Score above 80% for final exam", text: $goalDraft.goalName)
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
                    DatePicker("", selection: $goalDraft.deadline, displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 18).stroke(Color.gray.opacity(0.3)))
                }
                
                // Milestones
                VStack(alignment: .leading, spacing: 10) {
                    Text("Milestones")
                        .font(.headline)
                    Text("What are some major checkpoints to achieve this goal?")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    ForEach($goalDraft.milestones) { $milestone in
                        TextField("Milestone", text: $milestone.title)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 18).stroke(Color.gray.opacity(0.3)))
                    }
                }

                // Display error message if there is one
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .padding()
                }

                NavigationLink(destination: SetTasksView(goalDraft: goalDraft), isActive: $shouldNavigate) {
                    EmptyView()
                }
                .hidden()

                Button(action: {
                    if validateFields() {
                        print("Goal Name: \(goalDraft.goalName)")
                        print("Deadline: \(goalDraft.deadline)")
                        for (index, milestone) in goalDraft.milestones.enumerated() {
                            print("Milestone \(index + 1): \(milestone.title)")
                        }
                        shouldNavigate = true
                    } else {
                        errorMessage = "❌ Please fill in all fields correctly."
                    }
                }) {
                    Text("Next")
                        .frame(width: 343, height: 45)
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

    func validateFields() -> Bool {
        let today = Calendar.current.startOfDay(for: Date())

        return !goalDraft.goalName.isEmpty &&
               !goalDraft.deadline.description.isEmpty &&
               goalDraft.deadline > today &&
               goalDraft.milestones.allSatisfy { !$0.title.isEmpty }
    }
}

#Preview {
    NavigationStack {
        SetGoalView(goalDraft: GoalModel())
    }
}

