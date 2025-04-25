//
//  ProgressHubView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-23.
//

import SwiftUI

struct ProgressHubView: View {
    @StateObject private var viewModel = ProgressViewModel()
    @State private var selectedGoalIndex: Int = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 4) {
                    Text("Progress Hub")
                        .font(.system(size: 20, weight: .heavy))
                        .accessibilityLabel("Progress Hub")
                    Text("Your progress so far")
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // Goal Picker
                Picker("Select a Goal", selection: $selectedGoalIndex) {
                    ForEach(viewModel.goals.indices, id: \.self) { index in
                        Text(viewModel.goals[index].goalName).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(5)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .padding(10)
                .accessibilityLabel("Select a Goal")
                .accessibilityHint("Tap to choose a goal.")
                .accessibilityValue(viewModel.goals[selectedGoalIndex].goalName)
                
                //Dynamic Progress Ring Based on Goal
                if viewModel.goals.indices.contains(selectedGoalIndex) {
                    let goal = viewModel.goals[selectedGoalIndex]
                    let completionPercentage = goal.completedTasks == 0 ? 0 : Double(goal.completedTasks) / Double(goal.totalTasks)
                    
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 14)
                            .accessibility(hidden: true)
                        
                        Circle()
                            .trim(from: 0.0, to: completionPercentage)
                            .stroke(Color.BG_1, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .accessibilityLabel("Progress circle")
                        
                        Text("\(Int(completionPercentage * 100))%")
                            .font(.system(size: 40, weight: .semibold, design: .rounded))
                            .accessibilityLabel("Completion Percentage")
                            .accessibilityValue("\(Int(completionPercentage * 100)) percent")
                            .accessibilityHint("This indicates your progress.")
                    }
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 20)
                    
                    //Congrats Banner
                    Text("Congrats!!\nYou have completed \(Int(completionPercentage * 100))%")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.BG_1)
                        .cornerRadius(14)
                        .padding(.horizontal)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 2)
                    
                    //Progress Info
                    VStack(alignment: .leading, spacing: 30) {
                        HStack {
                            Text("Total Tasks Completed")
                            Spacer()
                            Text("\(goal.completedTasks)/\(goal.totalTasks)").bold()
                                .accessibilityLabel("Total Tasks Completed \(goal.completedTasks)/\(goal.totalTasks)")
                        }
                        
                        HStack {
                            Text("Total Time Tracked")
                            Spacer()
                            Text("\(formattedTime(goal.timeTracked))").bold()
                                .accessibilityLabel("Total Time Tracked \(formattedTime(goal.timeTracked))")
                        }
                        
                        HStack {
                            Text("No. days left")
                            Spacer()
                            Text("\(daysRemaining(for: goal.deadline))").bold()
                                .accessibilityLabel("No. days left \(daysRemaining(for: goal.deadline))")
                        }
                    }
                    .padding(30)
                }

                Spacer()
            }
            .onAppear {
                viewModel.fetchGoals()
            }
            .padding(.top)
        }
    }
    
    //MARK: - Methods
    
    private func formattedTime(_ minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        return "\(hours)hrs \(mins)mins"
    }
    
    private func daysRemaining(for deadline: Date) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        let remainingDays = calendar.dateComponents([.day], from: currentDate, to: deadline).day ?? 0
        return "\(remainingDays) days"
    }
}

#Preview {
    ProgressHubView()
}
