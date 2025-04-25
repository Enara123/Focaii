//
//  FocusTimerBundle.swift
//  FocusTimer
//
//  Created by Siluni on 2025-04-23.
//

import WidgetKit
import SwiftUI

@main
struct FocusTimerBundle: WidgetBundle {
    var body: some Widget {
        FocusTimer()
        FocusTimerControl()
        FocusTimerLiveActivity()
    }
}
