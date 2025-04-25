//
//  StepIndicator.swift
//  Focaii
//
//  Created by Siluni on 2025-04-18.
//
import SwiftUI

struct RectangleStepIndicator: View {
    let totalSteps: Int
    let currentStep: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalSteps, id: \.self) { index in
                RoundedRectangle(cornerRadius: 4)
                    .fill(index <= currentStep ? Color.BG_1 : Color.gray.opacity(0.2))
                    .frame(width: 75, height: 6)
                    .animation(.easeInOut(duration: 0.3), value: currentStep)
            }
        }
        .padding(.vertical, 16)
    }
}
