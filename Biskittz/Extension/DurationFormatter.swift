//
//  DurationFormatter.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 16/06/26.
//

import Foundation

enum DurationFormatter {
    static func formattedDuration(for duration: Int) -> String {
        if duration > 3540 { // 3540 sec (59 min) - to cover "x hr x min" formatting if the duration is more than 59 min
            let hours = duration / 3600
            if duration % 3600 == 0 {
                return "\(hours) hr"
            } else {
                return "\(hours) hr \((duration % 3600) / 60) min"
            }
        } else {
            let minutes = duration / 60
            return "\(minutes) min" // formatting "x min" only if the duration is less than 1 hour min
        }
    }
}
