//
//  ActivityModel.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 12/06/26.
//

import Foundation


struct ActivityModel: Identifiable, Hashable {
    static func == (lhs: ActivityModel, rhs: ActivityModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID
    var title: String       //ex: "Study", "Learn SwiftUI State-Binding"
    var duration: Int       //In seconds, ex: 5 min preset will be stored as 300
    var sessions: [SessionModel]    //ex: "3 sessions"
    var lastUsed: Date?
    
    var sessionCount: Int {
        sessions.count
    }
    
    init(id: UUID = UUID(), title: String, duration: Int) {
        self.id = id
        self.title = title
        self.duration = duration
        self.sessions = []
        self.lastUsed = nil // always nil on creation, updated later by ViewModel
    }
    
}

// for previewing with mock data
extension ActivityModel {
    init(
        id: UUID = UUID(),
        title: String,
        duration: Int,
        sessions: [SessionModel],
        lastUsed: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.duration = duration
        self.sessions = sessions
        self.lastUsed = lastUsed
    }
}
