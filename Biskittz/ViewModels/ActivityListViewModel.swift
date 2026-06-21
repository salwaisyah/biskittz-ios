//
//  ActivityListViewModel.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 13/06/26.
//

import Foundation
import Observation

@Observable
class ActivityListViewModel {
    var activities: [ActivityModel] = [] // no @Published property wrapper needed anymore
    
    // create a new activity
    func addActivity(title: String, duration: Int) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedTitle.isEmpty else {
            return
        }
        
        let activity = ActivityModel(title: trimmedTitle, duration: duration)
        
        activities.append(activity)
    }
    
    func logSession(activityID: UUID) {
//        guard let index = activities.firstIndex(where: { $0.id == activityID }) else {
//                return
//            }
        
        if let index = activities.firstIndex(where: { $0.id == activityID }) {
            var updatedActivity = activities[index]
            
            print("Looking for activity:", activityID)
            print("Found activity at index:", index)
            
            let session = SessionModel(activityId: activityID)
            updatedActivity.sessions.append(session)
            updatedActivity.lastUsed = Date()
            
            var updatedActivities = activities
            updatedActivities[index] = updatedActivity
            activities = updatedActivities
            
            print(
                "Session count:", activities[index].sessions.count
            )
            
            print("Sessions after update:", activities[index].sessions.count)
            print("Activities array count:", activities.count)
            
            
        }
        // SessionModel += 1 when the timer in timer screen reaches 0
    }
}
