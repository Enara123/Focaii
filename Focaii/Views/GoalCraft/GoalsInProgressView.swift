//
//  GoalsInProgressView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-18.
//

import SwiftUI

struct GoalsInProgressView: View {
    @State var deadline: String = ""
    @State private var task1: String = ""
    @State private var task2: String = ""
    @State private var task3: String = ""
    @State private var task4: String = ""
    @State private var task5: String = ""
    @State private var task6: String = ""
    var body: some View {
        ScrollView {
            VStack(spacing: 20)   {
                VStack(spacing: 4) {
                    Text("Goals in Progress")
                        .font(.system(size: 20, weight: .heavy))
                    Text("All goals you are working on!")
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Deadline")
                            .font(.headline)
                        TextField("e.g. 02/04/25", text: $deadline)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Milestone 1")
                            .font(.headline)
                        
                        TextField("e.g. Study all chapters", text: $task1)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                        TextField("e.g. Practice with question papers", text: $task2)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                        TextField("e.g. Revision", text: $task3)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Milestone 1")
                            .font(.headline)
                        
                        TextField("e.g. Study all chapters", text: $task1)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                        TextField("e.g. Practice with question papers", text: $task2)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                        TextField("e.g. Revision", text: $task3)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Milestone 1")
                            .font(.headline)
                        
                        TextField("e.g. Study all chapters", text: $task1)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                        TextField("e.g. Practice with question papers", text: $task2)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                        TextField("e.g. Revision", text: $task3)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    }                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
        }
    }
}

#Preview {
    GoalsInProgressView()
}
