//
//  FocusTimeLiveActivityLiveActivity.swift
//  FocusTimeLiveActivity
//
//  Created by Siluni on 2025-04-22.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct FocusTimeLiveActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var isPaused: Bool
        var remainingTime: TimeInterval
        var startTime: Date
    }

    var goalName: String
}

struct FocusTimeLiveActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
            ActivityConfiguration(for: FocusTimeLiveActivityAttributes.self) { context in
                // Lock Screen / Banner UI
                VStack {
                    Text(context.attributes.goalName)
                        .font(.headline)
                    if context.state.isPaused {
                        Text("Paused")
                            .foregroundColor(.orange)
                    } else {
                        Text("Focusing...")
                            .foregroundColor(.green)
                    }

                    ProgressView(value: context.state.remainingTime,
                                 total: 25 * 60) // replace with dynamic total if needed
                }
                .padding()
            } dynamicIsland: { context in
                DynamicIsland {
                    DynamicIslandExpandedRegion(.center) {
                        Text(context.attributes.goalName)
                        Text(context.state.isPaused ? "Paused" : "Focusing")
                    }
                    DynamicIslandExpandedRegion(.trailing) {
                        Text("\(Int(context.state.remainingTime / 60)) min left")
                    }
                } compactLeading: {
                    Text("⏳")
                } compactTrailing: {
                    Text(context.state.isPaused ? "⏸" : "▶️")
                } minimal: {
                    Text("🧠")
                }
            }
        }
}

extension FocusTimeLiveActivityAttributes {
    fileprivate static var preview: FocusTimeLiveActivityAttributes {
        FocusTimeLiveActivityAttributes(name: "World")
    }
}

extension FocusTimeLiveActivityAttributes.ContentState {
    fileprivate static var smiley: FocusTimeLiveActivityAttributes.ContentState {
        FocusTimeLiveActivityAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: FocusTimeLiveActivityAttributes.ContentState {
         FocusTimeLiveActivityAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: FocusTimeLiveActivityAttributes.preview) {
   FocusTimeLiveActivityLiveActivity()
} contentStates: {
    FocusTimeLiveActivityAttributes.ContentState.smiley
    FocusTimeLiveActivityAttributes.ContentState.starEyes
}
