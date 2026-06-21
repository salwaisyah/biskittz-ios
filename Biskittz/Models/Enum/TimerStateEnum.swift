//
//  TimerStateEnum.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 12/06/26.
//

import Foundation
import SwiftUI

enum TimerState {
    case idle
    case running
    case paused
    case completed
    
    var animationName: String {
        switch self {
        case .idle:      return "cat-idle"
        case .running:   return "cat-kneading"
        case .paused:    return "cat-questioning"
        case .completed: return "cat-completed"
        }
    }
}
