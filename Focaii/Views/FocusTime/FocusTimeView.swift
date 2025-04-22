//
//  FocusMenuView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-21.
//

import SwiftUI

struct FocusTimeView: View {
    @StateObject private var viewModel = GoalsViewModel()
    @State private var selectedTask: TaskInfo? = nil
    @State private var selectedTimerType: Int = 0
    @State private var navigateToNextView = false

    var body: some View {
        ScrollView() {
            VStack(spacing: 20) {
                VStack(spacing: 4) {
                    Text("Focus Time")
                        .font(.system(size: 20, weight: .heavy))
                    Text("Track time on tasks")
                        .padding(.bottom, 20)
                }

                Image("Main2")

                VStack(alignment: .leading, spacing: 10) {
                    Text("Select Timer")
                        .font(.headline)

                    HStack {
                        Picker("", selection: $selectedTimerType) {
                            Text("Pomodoro - 25 mins").tag(0)
                            Text("Time Toggle").tag(1)
                        }
                        .labelsHidden()
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(6)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Pick a Task")
                        .font(.headline)

                    HStack {
                        Picker("Select a Task", selection: $selectedTask) {
                            Text("None Selected").tag(nil as TaskInfo?)

                            ForEach(viewModel.allTaskInfos) { task in
                                VStack(alignment: .leading) {
                                    Text(task.title)
                                    Text("\(task.goalName) → \(task.milestoneTitle)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .tag(task as TaskInfo?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)

                    }
                    .padding(6)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                
                NavigationLink(
                    destination: TimerView(
                        taskTitle: selectedTask?.title ?? "",
                        goalName: selectedTask?.goalName ?? "",
                        timerType: selectedTimerType == 0 ? .pomodoro : .stopwatch
                    ),
                    isActive: $navigateToNextView
                ) {
                    EmptyView()
                }

                Button(action: {
                    if selectedTask != nil {
                            navigateToNextView = true
                        } else {
                            // Show a message or haptic feedback
                            print("⚠️ No task selected!")
                        }
                }) {
                    Text("Start Timer")
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.accent, lineWidth: 2)
                        )
                        .foregroundColor(Color.accent)
                        .padding(.top, 15)
                }
            }
            .onAppear {
                viewModel.fetchGoals()
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    FocusTimeView()
}
