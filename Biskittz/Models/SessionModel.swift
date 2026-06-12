//
//  SessionModel.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 12/06/26.
//

import Foundation

struct SessionModel: Identifiable {
    let id: UUID
    let activityId: UUID    //fethed from parent activity
    let completedAt: Date
    let duration: Int       //In minutes
    
    init(id: UUID = UUID(), activityId: UUID, duration: Int) {
        self.id = id
        self.activityId = activityId
        self.completedAt = Date() //Current date
        self.duration = duration
    }
}
