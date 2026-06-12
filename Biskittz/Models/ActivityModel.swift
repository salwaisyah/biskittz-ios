//
//  ActivityModel.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 12/06/26.
//

import Foundation


struct ActivityModel: Identifiable {
    let id: UUID
    var title: String       //ex: "Study", "Learn SwiftUI State-Binding"
    var duration: Int       //In minutes. ex: 5 minutes
    var sessions: [SessionModel]    //ex: "3 sessions"
    var lastUsed: Date?
    
    var sessionCount: Int {
        sessions.count
    }
    
    init(id: UUID = UUID(), title: String, duration: Int, lastUsed: Date? = nil) {
        self.id = id
        self.title = title
        self.duration = duration
        self.sessions = []
        self.lastUsed = lastUsed
    }
    
}
