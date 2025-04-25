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
    @State private var showAlert = false

    var body: some View {
        ScrollView() {
            VStack(spacing: 20) {
                VStack(spacing: 4) {
                    Text("Focus Time")
                        .font(.system(size: 20, weight: .heavy))
                        .accessibilityLabel("Focus Time")
                    Text("Track time on tasks")
                        .padding(.bottom, 20)
                }

                Image("Main2")
                    .accessibilityHidden(true)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select Timer")
                        .font(.headline)

                    HStack {
                        Picker("Select timer type", selection: $selectedTimerType) {
                            Text("Pomodoro - 25 mins").tag(0)
                            Text("Time Toggle").tag(1)
                        }
                        .labelsHidden()
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityLabel("Timer type picker")
                        .accessibilityValue(selectedTimerType == 0 ? "Pomodoro. 25 minutes" : "Time Toggle")
                        .accessibilityHint("Double tap to change timer type")
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
                        .accessibilityAddTraits(.isHeader)

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
                        .accessibilityLabel("Task picker")
                        .accessibilityValue(selectedTask.map {
                            "\($0.title), from goal \($0.goalName), milestone \($0.milestoneTitle)"
                        } ?? "No task selected")
                        .accessibilityHint("Double tap to choose a task for the timer")
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
                            showAlert = true
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
                        .accessibilityLabel("Start timer button")
                        .accessibilityHint("Double tap to start timer")
                }
            }
            .onAppear {
                viewModel.fetchGoals()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .alert("Please select a task!", isPresented: $showAlert, actions: {
                Button("OK", role: .cancel) {
                    
                }
            }, message: {
                Text("You must select a task to start the timer.")
                    .accessibilityLabel("You must select a task to start the timer.")
            })
        }
    }
}

#Preview {
    FocusTimeView()
}
