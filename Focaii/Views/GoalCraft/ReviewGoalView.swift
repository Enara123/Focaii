//
//  ReviewGoalView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-18.
//

import SwiftUI

struct ReviewGoalView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 4) {
                    Text("Review Goal")
                        .font(.system(size: 20, weight: .heavy))
                    Text("See if it's all good")
                }
                .frame(maxWidth: .infinity, alignment: .center)

                RectangleStepIndicator(totalSteps: 3, currentStep: 2)
                
                VStack(alignment: .leading, spacing: 20) {
                        Text("Score above 80% for final exam")
                        .font(.system(size: 20, weight: .bold))
            
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Deadline:")
                            .font(.headline)
                        Text("02/05/25")
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("1. Study all chapters")
                            .font(.headline)
                        Text("• Study chap 1")
                        Text("• Study chap 2")
                        Text("• Study chap 3")
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("2. Practice with question papers")
                            .font(.headline)
                        Text("• Do paper 1")
                        Text("• Do paper 2")
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("3. Revision")
                            .font(.headline)
                        Text("• Go through short notes")
                        Text("• Redo paper 1")
                        Text("• Review notes")
                    }
                }

                NavigationLink(destination: Dashboard()) {
                    Text("Set Goal!")
                        .frame(width: 343, height: 45)
                        .background(Color.accent)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                        .shadow(color: .black.opacity(0.7), radius: 2, x: 2, y: 2)
                }
            }
        }
    }
}

#Preview {
    ReviewGoalView()
}

