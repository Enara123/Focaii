//
//  SetTasksView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-18.
//

import SwiftUI

struct SetTasksView: View {
    @ObservedObject var goalDraft: GoalModel
    @State private var shouldNavigate = false
    @State private var errorMessage: String? = nil
    
    var body: some View {
        ScrollView() {
            VStack(spacing: 15) {
                VStack(spacing: 4) {
                    Text("Break it Down")
                        .font(.system(size: 20, weight: .heavy))
                    Text("Break milestones to tasks")
                        .accessibilityLabel("Let's break down each milestone into tasks")
                }
                
                RectangleStepIndicator(totalSteps: 3, currentStep: 1)
                    .accessibilityLabel("You are on step 2.")
                
                ForEach($goalDraft.milestones) { $milestone in
                    MilestoneView(milestone: $milestone)
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .padding()
                        .accessibilityLabel(errorMessage)
                }
                
                NavigationLink(destination: ReviewGoalView(goalDraft: goalDraft), isActive: $shouldNavigate) {
                    EmptyView()
                }
                .hidden()
                
                Button(action: {
                    if validateFields() {
                        print("✅ All fields valid.")
                        for (index, milestone) in goalDraft.milestones.enumerated() {
                            print("Milestone \(index + 1): \(milestone.title)")
                            for task in milestone.tasks {
                                print("  - \(task)")
                            }
                        }
                        shouldNavigate = true
                    } else {
                        errorMessage = "Please add at least one task to each milestone."
                    }
                }) {
                    Text("Review Goal")
                        .frame(width: 368, height: 45)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.accent, lineWidth: 2))
                        .foregroundColor(Color.accent)
                        .padding(.top, 15)
                        .accessibilityLabel("Review Goal Button")
                        .accessibilityHint("Tap to Review Goal")
                }
            }
            .padding()
        }
    }
    
    //MARK: - Methods
    func validateFields() -> Bool {
        return goalDraft.milestones.allSatisfy { milestone in
            milestone.tasks.contains(where: { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })
        }
    }
}

//MARK: - Milestone component to add tasks
struct MilestoneView: View {
    @Binding var milestone: Milestone

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(milestone.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)

            Text("Add tasks")
                .font(.system(size: 15))
                .accessibilityHint("List of tasks under this milestone")

            ForEach(milestone.tasks.indices, id: \.self) { index in
                HStack {
                    TextField("Enter task...", text: $milestone.tasks[index])
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .accessibilityLabel("Task \(index + 1) for milestone \(milestone.title)")
                        .accessibilityHint("Enter the task description")

                    Button(action: {
                        milestone.tasks.remove(at: index)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .accessibilityLabel("Delete task \(index + 1)")
                            .accessibilityHint("Removes this task from the milestone")
                    }
                    .padding(.leading, 8)
                }
            }

            Button(action: {
                milestone.tasks.append("")
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add another task")
                }
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color.accent)
            }
            .padding(.top, 5)
            .accessibilityLabel("Add another task button")
            .accessibilityHint("Adds a new task to this milestone")
        }
    }
}

#Preview {
    SetTasksView(goalDraft: GoalModel())
}
