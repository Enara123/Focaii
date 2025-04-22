//
//  ReviewGoalView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-18.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ReviewGoalView: View {
    @ObservedObject var goalDraft: GoalModel

    @State private var showSuccessAlert = false
    @State private var shouldNavigate = false
    @State private var errorMessage: String?

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
                
                // Goal Overview Card
                VStack(alignment: .leading, spacing: 20) {
                    Text(goalDraft.goalName)
                        .font(.title2)
                        .bold()
                        .frame(width: 300, alignment: .leading)

                    HStack {
                        Image(systemName: "calendar")
                        Text("Deadline: \(formatDate(goalDraft.deadline))")
                    }
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .frame(width: 300, alignment: .leading)
                }
                .frame(width: 320)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.BG_2)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                )


                // Milestones Section
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(goalDraft.milestones.indices, id: \.self) { i in
                        let milestone = goalDraft.milestones[i]
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Milestone \(i + 1): \(milestone.title)")
                                .font(.headline)
                                .frame(width: 300, alignment: .leading)

                            VStack(alignment: .leading, spacing: 6) {
                                ForEach(milestone.tasks.filter { !$0.isEmpty }, id: \.self) { task in
                                    HStack(alignment: .top) {
                                        Image(systemName: "circle")
                                            .foregroundColor(.accentColor)
                                        Text(task)
                                            .font(.subheadline)
                                            .frame(width: 260, alignment: .leading)
                                    }
                                }
                            }
                            .padding(.top, 5)
                        }
                        .frame(width: 320)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(Color(.systemBackground))
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                        )
                    }
                }
                
                .alert("Goal Saved!", isPresented: $showSuccessAlert) {
                    Button("OK") {
                        shouldNavigate = true
                    }
                } message: {
                    Text("Your goal has been successfully saved.")
                }

                NavigationLink(destination: GoalHomeView(), isActive: $shouldNavigate) {
                    EmptyView()
                }
                .hidden()

                Button(action: {
                    submitGoalToFirestore()
                }) {
                    Text("Set Goal!")
                        .frame(width: 368, height: 45)
                        .background(Color.accent)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.7), radius: 2, x: 2, y: 2)
                }

            }
        }
    }
    
    func submitGoalToFirestore() {
        let db = Firestore.firestore()
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let goalData: [String: Any] = [
            "goalName": goalDraft.goalName,
            "deadline": goalDraft.deadline,
            "milestones": goalDraft.milestones.map { milestone in
                return [
                    "title": milestone.title,
                    "tasks": milestone.tasks.filter { !$0.isEmpty }
                ]
            },
            "createdAt": Timestamp()
        ]

        db.collection("usernames")
            .document("Siluni")
            .collection("goals")
            .addDocument(data: goalData) { error in
                if let error = error {
                    print("❌ Error saving goal: \(error.localizedDescription)")
                } else {
                    print("✅ Goal saved!")
                    showSuccessAlert = true
                }
            }
    }


}

#Preview {
    ReviewGoalView(goalDraft: GoalModel())
}

