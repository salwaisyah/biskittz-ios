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
    
    var dotColor: Color {
            switch self {
            case .idle:    return .blue
            case .running: return .green
            case .paused:  return .orange
            case .completed: return .indigo
            }
    }
}
