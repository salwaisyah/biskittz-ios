//
//  PresetButtonStateEnum.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 16/06/26.
//

import Foundation
import SwiftUI

// MARK: Preset button state
enum PresetButtonState {
    case selected
    case unselected
}

// MARK: Preset Button Component
struct PresetButton: View {
    @State var currentState: PresetButtonState = .unselected
    @State var preset: String = ""
    @Binding var duration: Int
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    private var parsedLabel: Int? { // parsed the button label to second
        if preset.contains("\nmin") {
            let minuteString = Int(preset.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0
            let minutes = Int(minuteString)
            return minutes * 60 // convert minute to second
        } else if preset.contains("\nhr") {
            let hourString = Int(preset.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0
            let hours = Int(hourString)
            return hours * 3600 // convert hours to second
        } else {
            return nil
        }
    }
    
    var body: some View {
        Button {
            if let value = parsedLabel {
                duration = value // already in second bcs it was calculated in parsedLabel
                
                if value >= 3600 {
                    hours = value / 3600
                    minutes = 0
                    seconds = 0
                } else {
                    hours = 0
                    minutes = value / 60
                    seconds = 0
                }
                currentState = .selected
                
                //debug
                print("Preset '\(preset)' selected. hours=\(hours), minutes=\(minutes), seconds=\(seconds), duration=\(duration)")
            }
        } label: {
            let isSelected = (parsedLabel != nil && (minutes == parsedLabel! || hours == parsedLabel!)) || currentState == .selected
            Text(preset)
                .padding(24)
                .font(.title3)
                .bold()
                .background(isSelected ? Color.blue : Color.gray.opacity(0.3))
                .clipShape(Circle())
                .foregroundColor(isSelected ? .white : .primary)
        }
        .onChange(of: duration) { _, newValue in
            if let value = parsedLabel {
                currentState = (newValue == value) ? .selected : .unselected
            }
        }
    }
}

#Preview {
    struct PresetButtonPreview: View {
        @State private var duration: Int = 0
        @State private var hours: Int = 0
        @State private var minutes: Int = 0
        @State private var seconds: Int = 0
        var body: some View {
            HStack(spacing: 16) {
                PresetButton(currentState: .selected, preset: "5\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                PresetButton(currentState: .unselected, preset: "25\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
            }
            .padding()
        }
    }
    return PresetButtonPreview()
}
