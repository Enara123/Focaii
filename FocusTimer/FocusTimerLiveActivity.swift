//
//  FocusTimerLiveActivity.swift
//  FocusTimer
//
//  Created by Siluni on 2025-04-23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct FocusTimerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var startTime: Date
        var isPaused: Bool
        var pausedAt: Date?
        var timerDuration: TimeInterval?
    }
    
    var taskName: String
    var goalName: String
}

struct FocusTimerLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FocusTimerAttributes.self) { context in
            
            VStack(alignment: .leading, spacing: 4) {
                Text(context.attributes.taskName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(context.attributes.goalName)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                Spacer()
                
                if let duration = context.state.timerDuration {
                    // COUNTDOWN TIMER (POMODORO)
                    if !context.state.isPaused {
                        let endTime = context.state.startTime.addingTimeInterval(duration)
                        Text(timerInterval: Date.now...endTime, countsDown: true)
                            .font(.system(size: 32, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                    } else {
                        let elapsedTime = context.state.startTime.distance(to: context.state.pausedAt ?? Date())
                        let remainingTime = max(0, duration - elapsedTime)
                        
                        let minutes = Int(remainingTime) / 60
                        let seconds = Int(remainingTime) % 60
                        Text(String(format: "%02d:%02d", minutes, seconds))
                            .font(.system(size: 32, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                    }
                } else {
                    // STOPWATCH (ELAPSED TIME)
                    if !context.state.isPaused {
                        Text(Date.now.addingTimeInterval(-context.state.startTime.timeIntervalSinceNow), style: .timer)
                            .font(.system(size: 32, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                    } else {
                        let pausedDuration = context.state.startTime.distance(to: context.state.pausedAt ?? Date())
                        let seconds = Int(pausedDuration)
                        let minutes = seconds / 60
                        let hours = minutes / 60
                        let displaySeconds = seconds % 60
                        let displayMinutes = minutes % 60
                        
                        if hours > 0 {
                            Text(String(format: "%d:%02d:%02d", hours, displayMinutes, displaySeconds))
                                .font(.system(size: 32, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)
                        } else {
                            Text(String(format: "%02d:%02d", displayMinutes, displaySeconds))
                                .font(.system(size: 32, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .activityBackgroundTint(Color.purple.opacity(0.4))
            .activitySystemActionForegroundColor(.white)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text(context.attributes.taskName)
                        .font(.headline)
                }
                
                DynamicIslandExpandedRegion(.center) {
                    Text(context.attributes.goalName)
                        .font(.subheadline)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    VStack(alignment: .trailing, spacing: 4) {

                        if let duration = context.state.timerDuration {
                            // COUNTDOWN TIMER (POMODORO)
                            if !context.state.isPaused {
                                let endTime = context.state.startTime.addingTimeInterval(duration)
                                Text(timerInterval: Date.now...endTime, countsDown: true)
                                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                            } else {
                                let elapsedTime = context.state.startTime.distance(to: context.state.pausedAt ?? Date())
                                let remainingTime = max(0, duration - elapsedTime)
                                
                                let minutes = Int(remainingTime) / 60
                                let seconds = Int(remainingTime) % 60
                                Text(String(format: "%02d:%02d", minutes, seconds))
                                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                            }
                        } else {
                            // STOPWATCH (ELAPSED TIME)
                            if !context.state.isPaused {
                                Text(Date.now.addingTimeInterval(-context.state.startTime.timeIntervalSinceNow), style: .timer)
                                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                            } else {
                                let pausedDuration = context.state.startTime.distance(to: context.state.pausedAt ?? Date())
                                let seconds = Int(pausedDuration)
                                let minutes = seconds / 60
                                let hours = minutes / 60
                                let displaySeconds = seconds % 60
                                let displayMinutes = minutes % 60
                                
                                if hours > 0 {
                                    Text(String(format: "%d:%02d:%02d", hours, displayMinutes, displaySeconds))
                                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                                        .foregroundColor(.white)
                                } else {
                                    Text(String(format: "%02d:%02d", displayMinutes, displaySeconds))
                                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Button(context.state.isPaused ? "Resume" : "Pause") {
     
                        }
                        .buttonStyle(.bordered)
                        .tint(.accent)
                        
                        Button("End") {

                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.accent)
                    }
                }
            } compactLeading: {
                Text(context.attributes.taskName.prefix(1))
                    .font(.headline)
            } compactTrailing: {
                if let duration = context.state.timerDuration {
                    // COUNTDOWN TIMER
                    if !context.state.isPaused {
                        let endTime = context.state.startTime.addingTimeInterval(duration)
                        Text(timerInterval: context.state.startTime...endTime, countsDown: true)
                            .monospacedDigit()
                            .font(.caption2)
                    } else {
                        Text("⏸")
                    }
                } else {
                    // STOPWATCH
                    if !context.state.isPaused {
                        Text(Date.now.addingTimeInterval(-context.state.startTime.timeIntervalSinceNow), style: .timer)
                            .monospacedDigit()
                            .font(.caption2)
                    } else {
                        Text("⏸")
                    }
                }
            } minimal: {
                if context.state.isPaused {
                    Text("⏸")
                } else {
                    Text("⏱")
                }
            }
        }
    }
}

extension FocusTimerAttributes {
    static var preview: FocusTimerAttributes {
        FocusTimerAttributes(
            taskName: "Read Book",
            goalName: "Study"
        )
    }
}

extension FocusTimerAttributes.ContentState {
    static var previewRunning: FocusTimerAttributes.ContentState {
        FocusTimerAttributes.ContentState(
            startTime: Date().addingTimeInterval(-300),
            isPaused: false,
            pausedAt: nil,
            timerDuration: nil
        )
    }
    
    static var previewPaused: FocusTimerAttributes.ContentState {
        FocusTimerAttributes.ContentState(
            startTime: Date().addingTimeInterval(-300),
            isPaused: true,
            pausedAt: Date(),
            timerDuration: nil
        )
    }
    
    static var previewCountdown: FocusTimerAttributes.ContentState {
        FocusTimerAttributes.ContentState(
            startTime: Date(),
            isPaused: false,
            pausedAt: nil,
            timerDuration: 1500
        )
    }
}

#Preview("Running", as: .content, using: FocusTimerAttributes.preview) {
    FocusTimerLiveActivity()
} contentStates: {
    FocusTimerAttributes.ContentState.previewRunning
}

#Preview("Paused", as: .content, using: FocusTimerAttributes.preview) {
    FocusTimerLiveActivity()
} contentStates: {
    FocusTimerAttributes.ContentState.previewPaused
}

#Preview("Countdown", as: .content, using: FocusTimerAttributes.preview) {
    FocusTimerLiveActivity()
} contentStates: {
    FocusTimerAttributes.ContentState.previewCountdown
}
