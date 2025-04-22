//
//  Timer.swift
//  Focaii
//
//  Created by Siluni on 2025-04-21.
//

import Foundation
import Combine
import UserNotifications
import ActivityKit

enum FocusTimerType {
    case pomodoro
    case stopwatch
}

class FocusTimerViewModel: ObservableObject {
    @Published var timeRemaining: Int = 0
    @Published var isRunning = false
    @Published var timerType: FocusTimerType = .pomodoro
    @Published var totalTime: Int = 1500

    private var timer: Timer?
    private let pomodoroDuration = 25 * 60

    func startTimer() {
        isRunning = true

        if timerType == .pomodoro {
            timeRemaining = pomodoroDuration
            schedulePomodoroCompletionNotification()
        } else if timeRemaining == 0 {
            timeRemaining = 0
            scheduleLongFocusReminder()
        }

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTimer()
        }
    }

    func updateTimer() {
        switch timerType {
        case .pomodoro:
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
            }
        case .stopwatch:
            timeRemaining += 1
        }
    }

    func pauseTimer() {
        isRunning = false
        timer?.invalidate()
    }

    func restartTimer() {
        pauseTimer()
        if timerType == .pomodoro {
            timeRemaining = pomodoroDuration
        } else {
            timeRemaining = 0
        }
    }

    func cancelTimer() {
        pauseTimer()
        timeRemaining = 0
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["pomodoro_complete", "break_reminder"])
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["pomodoro_complete", "break_reminder"])
    }

    func formattedTime() -> String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func trackedTime() -> String {
        let hours = timeRemaining / 3600
        let minutes = (timeRemaining % 3600) / 60
        let seconds = timeRemaining % 60

        var components: [String] = []

        if hours > 0 {
            components.append("\(hours)h")
        }
        if minutes > 0 {
            components.append("\(minutes)m")
        }
        if hours == 0 && minutes == 0 || seconds > 0 {
            components.append("\(seconds)s")
        }

        return components.joined(separator: " ")
    }
    
    func elapsedTime() -> String {
        let hours = timeElapsed / 3600
        let minutes = (timeElapsed % 3600) / 60
        let seconds = timeElapsed % 60

        var components: [String] = []

        if hours > 0 {
            components.append("\(hours)h")
        }
        if minutes > 0 {
            components.append("\(minutes)m")
        }
        if hours == 0 && minutes == 0 || seconds > 0 {
            components.append("\(seconds)s")
        }

        return components.joined(separator: " ")
    }
    
    func displayTime() -> String {
        switch timerType {
        case .pomodoro:
            return elapsedTime()
        case .stopwatch:
            return trackedTime()
        }
    }
    
    var timeElapsed: Int {
        return totalTime - timeRemaining
    }

    var progress: Double {
        if timerType == .pomodoro {
            return Double(pomodoroDuration - timeRemaining) / Double(pomodoroDuration)
        } else {
            return 1.0 
        }
    }
    
    func schedulePomodoroCompletionNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro Completed 🎉"
        content.body = "Time’s up! Take a short break and refresh yourself."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(pomodoroDuration), repeats: false)
        let request = UNNotificationRequest(identifier: "pomodoro_complete", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    func scheduleLongFocusReminder(after seconds: Int = 10) {
        let content = UNMutableNotificationContent()
        content.title = "Take a Break ☕️"
        content.body = "You've been focusing for a long time. A break can boost your productivity!"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        let request = UNNotificationRequest(identifier: "break_reminder", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

}

