//
//  ProgressModel.swift
//  Focaii
//
//  Created by Siluni on 2025-04-24.
//

import FirebaseFirestore
import SwiftUI
import Combine

class ProgressViewModel: ObservableObject {
    @Published var goals: [GoalProgress] = [] // The goals array to be displayed
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    // Fetch goals from Firestore
    func fetchGoals() {
        db.collection("usernames").document("Siluni").collection("progress")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching goals: \(error.localizedDescription)")
                    return
                }
                
                guard let snapshot = snapshot else { return }
                
                self.goals = snapshot.documents.compactMap { document in
                    try? document.data(as: GoalProgress.self)
                }
            }
    }
//    
//    // Fetch a specific goal from Firestore (if needed for detailed progress info)
//    func fetchGoalDetails(goalID: String) -> GoalProgress? {
//        return goals.first { $0.id == goalID }
//    }
}

struct GoalProgress: Identifiable, Codable {
    @DocumentID var id: String? // Firestore auto-generates IDs
    var goalName: String
    var totalTasks: Int
    var completedTasks: Int
    var timeTracked: Int // Time in minutes
    var deadline: Date
}
