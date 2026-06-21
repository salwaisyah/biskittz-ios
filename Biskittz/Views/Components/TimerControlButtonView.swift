//
//  TimerControlButtonView.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 18/06/26.
//

import SwiftUI

enum TimerControlButtonState {
    case startButton
    case stopButton
    case pauseButton
    case resumeButton
    case completeButton
    
    var tint: Color {
        switch self {
        case .startButton: return .blue
        case .stopButton: return .red
        case .pauseButton: return .orange
        case .resumeButton: return .green
        case .completeButton: return .indigo
        }
    }
    
    var label: String {
        switch self {
        case .startButton: return "Start"
        case .stopButton: return "Stop"
        case .pauseButton: return "Pause"
        case .resumeButton: return "Resume"
        case .completeButton: return "Complete"
        }
    }
    
    var icon: String {
        switch self {
        case .startButton: return "play.fill"
        case .stopButton: return "stop.fill"
        case .pauseButton: return "pause.fill"
        case .resumeButton: return "playpause.fill"
        case .completeButton: return "checkmark"
        }
    }
}

struct TimerControlButtonView: View {
    let state: TimerControlButtonState
    let buttonAction: () -> Void
    
    var body: some View {
        Button(action: buttonAction) {
            Label(state.label, systemImage: state.icon)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(state.tint)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(state.tint.opacity(0.12))
                .clipShape(Capsule())
        }
        .dynamicTypeSize(...DynamicTypeSize.accessibility2)
    }
}

#Preview {
    VStack(spacing: 16) {
        TimerControlButtonView(state: .stopButton, buttonAction: {})
        TimerControlButtonView(state: .startButton, buttonAction: {})
        TimerControlButtonView(state: .pauseButton, buttonAction: {})
        TimerControlButtonView(state: .resumeButton, buttonAction: {})
        TimerControlButtonView(state: .completeButton, buttonAction: {})
    }
    .padding()
}
