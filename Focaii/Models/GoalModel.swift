//
//  GoalModel.swift
//  Focaii
//
//  Created by Siluni on 2025-04-21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct Milestone: Identifiable, Codable {
    var id = UUID()
    var title: String
    var tasks: [String] = []
}

class GoalModel: ObservableObject, Codable {
    @Published var goalName: String
    @Published var deadline: Date
    @Published var milestones: [Milestone]

    enum CodingKeys: String, CodingKey {
        case goalName, deadline, milestones
    }

    init(
        goalName: String = "",
        deadline: Date = Date(),
        milestones: [Milestone] = [
            Milestone(title: "", tasks: [""]),
            Milestone(title: "", tasks: [""]),
            Milestone(title: "", tasks: [""])
        ]
    ) {
        self.goalName = goalName
        self.deadline = deadline
        self.milestones = milestones
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.goalName = try container.decode(String.self, forKey: .goalName)
        self.deadline = try container.decode(Date.self, forKey: .deadline)
        self.milestones = try container.decode([Milestone].self, forKey: .milestones)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(goalName, forKey: .goalName)
        try container.encode(deadline, forKey: .deadline)
        try container.encode(milestones, forKey: .milestones)
    }
}


class GoalsViewModel: ObservableObject {
    @Published var goals: [GoalModel] = []
    
    func fetchGoals() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("usernames").document(userId).collection("goals").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Error fetching goals: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.goals = documents.compactMap { doc -> GoalModel? in
                let data = doc.data()
                
                guard let goalName = data["goalName"] as? String,
                      let timestamp = data["deadline"] as? Timestamp,
                      let milestonesArray = data["milestones"] as? [[String: Any]]
                else {
                    return nil
                }
                
                let deadline = timestamp.dateValue()
                let milestones: [Milestone] = milestonesArray.compactMap { milestoneDict in
                    guard let title = milestoneDict["title"] as? String,
                          let tasks = milestoneDict["tasks"] as? [String] else {
                        return nil
                    }
                    return Milestone(title: title, tasks: tasks)
                }
                
                return GoalModel(goalName: goalName, deadline: deadline, milestones: milestones)
            }
        }
    }
}


