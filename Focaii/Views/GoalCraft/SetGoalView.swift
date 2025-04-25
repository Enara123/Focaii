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
                        .accessibilityLabel("Let's set a SMART goal together")
                }
                RectangleStepIndicator(totalSteps: 3, currentStep: 0)
                    .accessibilityLabel("There are 3 steps to this process. You are on step 1.")
                
                //MARK: - Goal setting form
                
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
                        .accessibilityLabel("Enter a goal name")
                        .accessibilityLabel("Example: Score above 80% for final exam")
                }
                
                // Deadline
                VStack(alignment: .leading, spacing: 10) {
                    Text("Deadline")
                        .font(.headline)
                        .accessibilityLabel("Set a deadline for your goal")
                    Text("By when do you want to achieve this goal?")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    DatePicker("", selection: $goalDraft.deadline, displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 18).stroke(Color.gray.opacity(0.3)))
                        .accessibilityLabel("Select a date")
                }
                
                // Milestones
                VStack(alignment: .leading, spacing: 10) {
                    Text("Milestones")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text("What are some major checkpoints to achieve this goal?")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityHint("Describe the milestones needed to complete the goal")

                    ForEach($goalDraft.milestones.indices, id: \.self) { index in
                        TextField("Milestone \(index + 1)", text: $goalDraft.milestones[index].title)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3))
                            )
                            .accessibilityLabel("Milestone \(index + 1)")
                            .accessibilityHint("Enter a milestone to reach your goal")
                    }
                }
                
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .padding()
                        .accessibilityLabel(errorMessage)
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
                        errorMessage = "Please fill in all fields."
                    }
                }) {
                    Text("Next")
                        .frame(width: 368, height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.accent, lineWidth: 2))
                        .foregroundColor(Color.accent)
                        .padding(.top, 15)
                        .accessibilityLabel("Next Button")
                        .accessibilityHint("Tap to go to next page")
                }
                
            }
            .padding()
        }
    }

    //MARK: - Methods
    
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

