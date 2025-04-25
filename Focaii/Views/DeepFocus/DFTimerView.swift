//
//  DFTimerView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-23.
//

import SwiftUI
import FamilyControls
import DeviceActivity
import ManagedSettings

struct DFTimerView: View {
    @StateObject private var viewModel = FocusTimerViewModel()
    @StateObject private var liveModel = FocusTimerLiveActivityManager()
    @StateObject private var player = MusicManager.shared
    @State private var showEndSessionAlert = false
    @State private var showTaskCompleteAlert = false
    @State private var navigateBack = false

    let taskTitle: String
    let goalName: String
    let timerType: FocusTimerType
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            VStack(alignment: .center) {
                Text(taskTitle)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 10)
                    .accessibilityLabel(taskTitle)

                Text(goalName)
                    .font(.subheadline)
                    .foregroundColor(Color.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .onAppear {
                        viewModel.timerType = timerType
                    }
                    .accessibilityLabel(goalName)
            }
            .frame(maxWidth: .infinity)
            .padding()
            
            // Dynamic Timer Ring
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 12)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(viewModel.progress))
                    .stroke(Color.BG_1, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear, value: viewModel.progress)
                
                Text(viewModel.formattedTime())
                    .font(.system(size: 36, weight: .semibold, design: .rounded))
            }
            .frame(width: 220, height: 220)
            
            // Timer Action Buttons
            HStack(spacing: 40) {
                TimerActionButton(
                    systemImage: "xmark",
                    action: {
                        viewModel.cancelTimer()
                        liveModel.endLiveActivity()
                    },
                    foregroundColor: .red.opacity(0.8),
                    backgroundColor: Color.red.opacity(0.1)
                )
                .accessibilityLabel("Cancel timer")
                .accessibilityHint("Stops the current focus time session.")

                TimerActionButton(
                    systemImage: viewModel.isRunning ? "pause.fill" : "play.fill",
                    action: {
                        if viewModel.isRunning {
                            viewModel.pauseTimer()
                            if let start = viewModel.startTime {
                                liveModel.updateLiveActivity(isPaused: true)
                            }
                        } else {
                            viewModel.startTimer()
                            if let start = viewModel.startTime {
                                liveModel.startLiveActivity(taskName: taskTitle, goalName: goalName)
                            }
                        }
                    },
                    isFilled: true,
                    foregroundColor: .gray,
                    backgroundColor: Color.gray.opacity(0.2)
                )
                .accessibilityLabel("Pause or Play timer")
                .accessibilityHint("Starts and pauses the current focus time session.")
                
                TimerActionButton(
                    systemImage: "gobackward",
                    action: viewModel.restartTimer,
                    foregroundColor: .blue,
                    backgroundColor: Color.blue.opacity(0.1)
                )
                .accessibilityLabel("Reset timer")
                .accessibilityHint("Researt the current focus time session.")
            }
            .padding(.top, 20)
            
            NavigationLink( destination: Dashboard(), isActive: $navigateBack
            ) {
                EmptyView()
            }
            
            MusicPlayerView()
            
            Button(action: {
                viewModel.stopTimer()
                liveModel.endLiveActivity()
                showEndSessionAlert = true
                player.stop()
            }) {
                Text("End Session")
                    .frame(maxWidth: .infinity)
                    .padding(14)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.accent, lineWidth: 2)
                    )
                    .foregroundColor(Color.accent)
                    .padding(.top, 15)
                    .accessibilityLabel("End session button")
                    .accessibilityHint("Double tap to end the focus time session")
            }
            .padding(.horizontal)
            
            Button(action: {
                viewModel.stopTimer()
                liveModel.endLiveActivity()
                showTaskCompleteAlert = true
                player.stop()
            }) {
                Text("Task Completed")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accent)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .accessibilityLabel("Task completed button")
                    .accessibilityHint("Double tap to mark the task as complete")
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            Spacer()

        }
        .alert("Session Ended", isPresented: $showEndSessionAlert, actions: {
            Button("OK", role: .cancel) {
                navigateBack = true
            }
        }, message: {
            Text("You tracked \(viewModel.displayTime()) on this task.")
                .accessibilityLabel("You tracked \(viewModel.displayTime()) on this task.")
        })
        .alert("🎉 Task Completed!", isPresented: $showTaskCompleteAlert, actions: {
            Button("Great!", role: .cancel) {
                navigateBack = true
            }
        }, message: {
            Text("Well done! You worked \(viewModel.displayTime()) on this task.")
                .accessibilityLabel("Well done! You worked \(viewModel.displayTime()) on this task.")
        })
        .padding(.top)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DFTimerView(taskTitle: "Task Title", goalName: "Goal Name", timerType: FocusTimerType.pomodoro)
}

