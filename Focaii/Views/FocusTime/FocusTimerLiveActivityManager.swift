//
//  FocusTimerLiveActivityManager.swift
//  FocusTimer
//
//  Created by Siluni on 2025-04-23.
//

import ActivityKit
import Foundation

class FocusTimerLiveActivityManager: ObservableObject {
    @Published private(set) var currentActivityID: String? = nil
    
    private var activity: Activity<FocusTimerAttributes>? = nil
    
    func startLiveActivity(taskName: String, goalName: String, timerDuration: TimeInterval? = nil) {
        endLiveActivity()
        
        let attributes = FocusTimerAttributes(taskName: taskName, goalName: goalName)
        let initialState = FocusTimerAttributes.ContentState(
            startTime: Date(),
            isPaused: false,
            pausedAt: nil,
            timerDuration: timerDuration
        )
        
        do {
            activity = try Activity.request(
                attributes: attributes,
                content: .init(state: initialState, staleDate: nil)
            )
            print("Started Live Activity with ID: \(activity?.id ?? "unknown")")
        } catch {
            print("Failed to start Live Activity: \(error)")
        }
    }
    
    func updateLiveActivity(isPaused: Bool) {
        Task {
            // Find the activity by ID if we have one saved
            guard let activityID = currentActivityID,
                  let activity = Activity<FocusTimerAttributes>.activities.first(where: { $0.id == activityID }) else {
                print("No matching activity found to update")
                return
            }
            
            let currentState = activity.content.state
            
            // Create new state based on whether we're pausing or resuming
            let newState: FocusTimerAttributes.ContentState
            
            if isPaused {
                // Pausing the timer
                newState = FocusTimerAttributes.ContentState(
                    startTime: currentState.startTime,
                    isPaused: true,
                    pausedAt: Date(),
                    timerDuration: currentState.timerDuration
                )
            } else {
                // Resuming the timer
                // If previously paused, adjust the start time
                var adjustedStartTime = currentState.startTime
                if let pausedAt = currentState.pausedAt {
                    let pausedDuration = pausedAt.timeIntervalSince(currentState.startTime)
                    adjustedStartTime = Date().addingTimeInterval(-pausedDuration)
                }
                
                newState = FocusTimerAttributes.ContentState(
                    startTime: adjustedStartTime,
                    isPaused: false,
                    pausedAt: nil,
                    timerDuration: currentState.timerDuration
                )
            }
            
            await activity.update(.init(state: newState, staleDate: nil))
        }
    }
    
    func endLiveActivity() {
        Task {
            if let activityID = currentActivityID,
               let activity = Activity<FocusTimerAttributes>.activities.first(where: { $0.id == activityID }) {
                await activity.end(dismissalPolicy: .immediate)
                currentActivityID = nil
            } else {
                for activity in Activity<FocusTimerAttributes>.activities {
                    await activity.end(dismissalPolicy: .immediate)
                }
            }
        }
    }
    
    // Get active Live Activities (useful for restoration and debugging)
    func getActiveLiveActivities() -> [Activity<FocusTimerAttributes>] {
        return Activity<FocusTimerAttributes>.activities
    }
    
    // End all active Live Activities (useful if you're hitting the limit)
    func endAllLiveActivities() {
        Task {
            for activity in Activity<FocusTimerAttributes>.activities {
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
}
