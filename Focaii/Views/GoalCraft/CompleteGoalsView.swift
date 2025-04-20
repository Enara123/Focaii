//
//  CompleteGoalsView.swift
//  Focaii
//
//  Created by Siluni on 2025-04-20.
//

import SwiftUI

struct CompleteGoalsView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Completed Goals")
                    .font(.system(size: 20, weight: .heavy))
                Text("Take a look at all your completed goals")
                    .padding(.bottom, 20)
                
                // Set a Goal
                
                HStack {
                    Image("DoneGoals")
                        .frame(width: 70, height: 70)
                        .background(Color.BG_2)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text("Complete Certification")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(Color.primary)
                            .padding(.bottom, 1)
                        Text("Date completed: April 20, 2025")
                            .font(.system(size: 15))
                            .foregroundColor(Color.primary)
                    }
                    .padding(.leading, 10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                
                HStack {
                    Image("DoneGoals")
                        .frame(width: 70, height: 70)
                        .background(Color.BG_2)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text("Score A+ for Physics")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(Color.primary)
                            .padding(.bottom, 1)
                        Text("Date completed: April 20, 2025")
                            .font(.system(size: 15))
                            .foregroundColor(Color.primary)
                    }
                    .padding(.leading, 10)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
            }
            .padding()
        }
    }
}

#Preview {
    CompleteGoalsView()
    
}
