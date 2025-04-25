//
//  TimerActionButton.swift
//  Focaii
//
//  Created by Siluni on 2025-04-23.
//

import SwiftUI

struct TimerActionButton: View {
    let systemImage: String
    let action: () -> Void
    var isFilled: Bool = false
    var foregroundColor: Color = .black
    var backgroundColor: Color = Color.clear
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: systemImage)
                    .font(.title2)
            }
            .foregroundColor(foregroundColor)
            .padding()
            .frame(width: 70, height: 70)
            .background(backgroundColor)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(foregroundColor.opacity(0.3), lineWidth: 1)
            )
        }
    }
}
