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
    
    func logSession(activityID: UUID, duration: Int) {
        if let sessionIndex = activities.firstIndex(where: { $0.id == activityID }) {
            let session = SessionModel(activityId: activityID, duration: duration)
            activities[sessionIndex].sessions.append(session)
            activities[sessionIndex].lastUsed = Date()
        }
        // SessionModel += 1 when the timer in timer screen reaches 0
    }
}
