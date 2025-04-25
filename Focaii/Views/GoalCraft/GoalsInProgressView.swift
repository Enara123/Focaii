//
//  GoalsInProgressView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-18.
//

import SwiftUI

struct GoalsInProgressView: View {
    @StateObject private var viewModel = GoalsViewModel()
    @State private var selectedGoalIndex: Int = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 4) {
                    Text("Goals in Progress")
                        .font(.system(size: 20, weight: .heavy))
                    Text("Choose a goal to see details")
                        .accessibilityLabel("Goals in Progress")
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Picker("Select a goal", selection: $selectedGoalIndex) {
                    ForEach(viewModel.goals.indices, id: \.self) { index in
                        Text(viewModel.goals[index].goalName).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .accessibilityLabel("Select a goal")
                .accessibilityValue(viewModel.goals[selectedGoalIndex].goalName)
                .accessibilityHint("Double tap to choose a goal")
                
                //Dynamically load the details of the goal
                if viewModel.goals.indices.contains(selectedGoalIndex) {
                    let selectedGoal = viewModel.goals[selectedGoalIndex]
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Deadline")
                            .font(.headline)
                        Text(formatDate(selectedGoal.deadline))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .accessibilityLabel("Deadline")
                            .accessibilityValue(formatDate(selectedGoal.deadline))

                        ForEach(selectedGoal.milestones.indices, id: \.self) { i in
                            let milestone = selectedGoal.milestones[i]
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Milestone \(i + 1): \(milestone.title)")
                                    .font(.headline)
                                    .accessibilityLabel("Milestone \(i + 1): \(milestone.title)")
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(milestone.tasks.filter { !$0.isEmpty }, id: \.self) { task in
                                        Text(task)
                                            .padding()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(
                                                RoundedRectangle(cornerRadius: 18)
                                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                            )
                                            .accessibilityLabel("Task: \(task)")
                                    }
                                }
                            }
                        }
                    }
                } else {
                    Text("No goals found.")
                        .foregroundColor(.gray)
                        .accessibilityLabel("No goal found.")
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchGoals()
        }
    }
}

#Preview {
    GoalsInProgressView()
}
