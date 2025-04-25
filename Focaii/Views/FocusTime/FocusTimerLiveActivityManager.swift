//
//  FocusTimerLiveActivityManager.swift
//  FocusTimer
//
//  Created by Siluni on 2025-04-23.
//

import ActivityKit
import Foundation

//Create an instance of the Live Activity Extension
class FocusTimerLiveActivityManager: ObservableObject {
    @Published private(set) var currentActivityID: String? = nil
    
    private var activity: Activity<FocusTimerAttributes>? = nil
    
    //Start Live Activity Session
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
            let newActivity = try Activity.request(
                attributes: attributes,
                content: .init(state: initialState, staleDate: nil)
            )
            
            DispatchQueue.main.async {
                self.currentActivityID = newActivity.id
            }
            
            print("Started Live Activity with ID: \(activity?.id ?? "unknown")")
        } catch {
            print("Failed to start Live Activity: \(error)")
        }
    }
    
    //Update Ongoing Live Activity Session when timer is paused/resumed
    func updateLiveActivity(isPaused: Bool) {
        Task {
            guard let activityID = currentActivityID,
                  let activity = Activity<FocusTimerAttributes>.activities.first(where: { $0.id == activityID }) else {
                print("No matching activity found to update")
                return
            }
            
            let currentState = activity.content.state
            
            let newState: FocusTimerAttributes.ContentState
            
            print("Found activity: \(activity.id)")


            if isPaused {
                print("Timer is paused.")
                newState = FocusTimerAttributes.ContentState(
                    startTime: currentState.startTime,
                    isPaused: true,
                    pausedAt: Date(),
                    timerDuration: currentState.timerDuration
                )
                
                print("isPaused: \(newState.isPaused), pausedAt: \(String(describing: newState.pausedAt))")
            } else {
                print("Timer is resumed.")
                var adjustedStartTime = currentState.startTime
                if let pausedAt = currentState.pausedAt {
                    let pausedDuration = pausedAt.timeIntervalSince(currentState.startTime)
                    adjustedStartTime = Date().addingTimeInterval(-pausedDuration)
                    print("Adjusted startTime after pause: \(adjustedStartTime)")
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
    
    //End Live Activity Session
    func endLiveActivity() {
        Task {
            if let activityID = currentActivityID,
               let activity = Activity<FocusTimerAttributes>.activities.first(where: { $0.id == activityID }) {
                await activity.end(dismissalPolicy: .immediate)
                self.currentActivityID = nil
            } else {
                for activity in Activity<FocusTimerAttributes>.activities {
                    await activity.end(dismissalPolicy: .immediate)
                }
            }
        }
    }
}
