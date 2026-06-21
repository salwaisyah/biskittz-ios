//
//  SessionModel.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 12/06/26.
//

import Foundation

struct SessionModel: Identifiable, Hashable {
    let id: UUID
    let activityId: UUID    //fethed from parent activity
    let completedAt: Date
    let duration: Int       //In seconds
    
    init(id: UUID = UUID(), activityId: UUID, duration: Int) {
        self.id = id
        self.activityId = activityId
        self.completedAt = Date() //Current date
        self.duration = duration
    }
}
