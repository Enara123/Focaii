//
//  GoalModel.swift
//  Focaii
//
//  Created by Siluni on 2025-04-21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct TaskInfo: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let goalName: String
    let milestoneTitle: String
}

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
    @Published var allTaskInfos: [TaskInfo] = []
    
    func fetchGoals() {
//        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("usernames").document("Siluni").collection("goals").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching goals: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else { return }

            var fetchedGoals: [GoalModel] = []
            var taskInfoList: [TaskInfo] = []

            for doc in documents {
                let data = doc.data()
                guard let goalName = data["goalName"] as? String,
                      let timestamp = data["deadline"] as? Timestamp,
                      let milestonesArray = data["milestones"] as? [[String: Any]]
                else { continue }

                let deadline = timestamp.dateValue()

                let milestones: [Milestone] = milestonesArray.compactMap { milestoneDict in
                    guard let title = milestoneDict["title"] as? String,
                          let tasks = milestoneDict["tasks"] as? [String] else { return nil }

                    for task in tasks {
                        let taskInfo = TaskInfo(title: task, goalName: goalName, milestoneTitle: title)
                        taskInfoList.append(taskInfo)
                    }

                    return Milestone(title: title, tasks: tasks)
                }

                let goal = GoalModel(goalName: goalName, deadline: deadline, milestones: milestones)
                fetchedGoals.append(goal)
            }

            DispatchQueue.main.async {
                self.goals = fetchedGoals
                self.allTaskInfos = taskInfoList
            }
        }
    }

}


