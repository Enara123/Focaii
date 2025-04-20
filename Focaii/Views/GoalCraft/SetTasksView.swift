//
//  SetTasksView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-18.
//

import SwiftUI

struct SetTasksView: View {
    @State private var milestone1Tasks: [String] = [""]
    @State private var milestone2Tasks: [String] = [""]
    @State private var milestone3Tasks: [String] = [""]
    
    var body: some View {
        ScrollView() {
            VStack(spacing: 15) {
                VStack(spacing: 4) {
                    Text("Break it Down")
                        .font(.system(size: 20, weight: .heavy))
                    Text("Break milestones to tasks")
                }
                
                RectangleStepIndicator(totalSteps: 3, currentStep: 1)
                
                // Milestone 1
                MilestoneView(title: "Study All Chapters", tasks: $milestone1Tasks)
                
                // Milestone 2
                MilestoneView(title: "Practice with question papers", tasks: $milestone2Tasks)
                
                // Milestone 3
                MilestoneView(title: "Revision", tasks: $milestone3Tasks)
                
                NavigationLink(destination: ReviewGoalView()) {
                    Text("Review Goal")
                        .frame(width: 343, height: 45)
                        .background(Color.accent)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                        .shadow(color: .black.opacity(0.7), radius: 2, x: 2, y: 2)
                }
            }
            .padding()
        }
    }
}

struct MilestoneView: View {
    var title: String
    @Binding var tasks: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)

            Text("Add tasks")
                .font(.system(size: 15))

            ForEach(tasks.indices, id: \.self) { index in
                HStack {
                    TextField("Enter task...", text: $tasks[index])
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )

                    Button(action: {
                        tasks.remove(at: index)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .padding(.leading, 8)
                }
            }

            Button(action: {
                tasks.append("")
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add another task")
                }
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color.accent)
            }
            .padding(.top, 5)
        }
    }
}

#Preview {
    SetTasksView()
}
