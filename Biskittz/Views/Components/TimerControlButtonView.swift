//
//  TimerControlButtonView.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 18/06/26.
//

import SwiftUI

enum TimerControlButtonState {
    case start
    case stop
    case pause
    case resume
    
    @ViewBuilder
    func makeButton(timerViewModel: TimerViewModel) -> some View {
        switch self {
        case .start:
            TimerControlButtonView(timerViewModel: timerViewModel, state: .start, label: "Start", icon: "play.fill", tint: .green)
        case .stop:
            TimerControlButtonView(timerViewModel: timerViewModel, state: .stop, label: "Stop", icon: "stop.fill", tint: .red)
        case .pause:
            TimerControlButtonView(timerViewModel: timerViewModel, state: .pause, label: "Pause", icon: "pause.fill", tint: .orange)
        case .resume:
            TimerControlButtonView(timerViewModel: timerViewModel, state: .resume, label: "Resume", icon: "playpause.fill", tint: .blue)
        }
    }
}

struct TimerControlButtonView: View {
    var timerViewModel: TimerViewModel
    var state: TimerControlButtonState
    var label: String
    var icon: String
    var tint: Color
    
    var body: some View {
        Button(action: buttonAction) {
            Label(label, systemImage: icon)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(tint)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(tint.opacity(0.12))
                .clipShape(Capsule())
        }
        .dynamicTypeSize(...DynamicTypeSize.accessibility2)
    }
    
    private func buttonAction() {
        switch state {
        case .start:
            timerViewModel.start()
        case .stop:
            timerViewModel.stop()
        case .pause:
            timerViewModel.pause()
        case .resume:
            timerViewModel.start()
        }
    }
}

#Preview {
    let activity = ActivityModel(id: UUID(), title: "Preview Activity", duration: 1500)
    let timerVM = TimerViewModel(activity: activity)
    return VStack(spacing: 16) {
        TimerControlButtonState.stop.makeButton(timerViewModel: timerVM)
        TimerControlButtonState.start.makeButton(timerViewModel: timerVM)
        TimerControlButtonState.pause.makeButton(timerViewModel: timerVM)
        TimerControlButtonState.resume.makeButton(timerViewModel: timerVM)
    }
    .padding()
}
