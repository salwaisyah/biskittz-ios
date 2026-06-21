//
//  TimerScreenView.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 18/06/26.
//

import SwiftUI

// MARK: - Main Screen
struct TimerScreenView: View {
    @State var activityViewModel: ActivityListViewModel = ActivityListViewModel()
    
    // Inputs — will wire these up to a ViewModel later
    var duration: Int = 290          // total seconds
    var remaining: Int = 290         // seconds left
    var timerState: TimerState = .idle
    
    // MARK: Derived
    private var progress: Double {
        guard duration > 0 else { return 0 }
        return Double(remaining) / Double(duration)
    }
    
    private var hours: Int   { remaining / 3600 }
    private var minutes: Int { (remaining % 3600) / 60 }
    private var seconds: Int { remaining % 60 }
    private var showHours: Bool { duration >= 3600 }
     
    // MARK: Body
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            ringSection
            Spacer().frame(height: 48)
            timeDisplay
            Spacer()
            buttonRow
                .padding(.bottom, 48)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Study Swift: State & Binding")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: ringSection
    private var ringSection: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let ringRadius = size * 0.42
            let lineWidth: CGFloat = 14
            let dotSize: CGFloat = size * 0.28
            
            ZStack {
                // Track
                Circle()
                    .stroke(Color(.systemGray4), lineWidth: lineWidth)
                
                // Progress arc
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.blue,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 0.5), value: progress)
                
                // Tail dot — fixed at 12 o'clock
                Circle()
                    .fill(.white)
                    .frame(width: lineWidth - 2, height: lineWidth - 2)
                    .offset(y: -ringRadius)
                    .opacity(progress > 0.02 ? 1 : 0)
                
                // Tip dot — leading edge of arc
                tipDot(ringRadius: ringRadius, lineWidth: lineWidth)
                
                // Center state dot
                Circle()
                    .fill(timerState.dotColor)
                    .frame(width: dotSize, height: dotSize)
                    .animation(.easeInOut(duration: 0.3), value: timerState.dotColor)
            }
            .frame(width: size, height: size)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
        }
        .frame(width: 260, height: 260)
    }
    
    @ViewBuilder
    private func tipDot(ringRadius: CGFloat, lineWidth: CGFloat) -> some View {
        let angle = Angle(degrees: -90 + progress * 360)
        let x = cos(angle.radians) * ringRadius
        let y = sin(angle.radians) * ringRadius
        
        Circle()
            .fill(.blue)
            .frame(width: lineWidth - 2, height: lineWidth - 2)
            .offset(x: x, y: y)
            .opacity(progress > 0.02 && progress < 0.98 ? 1 : 0)
            .animation(.linear(duration: 0.5), value: progress)
    }
    
    // MARK: Time Display
    private var timeDisplay: some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            if showHours {
                timeUnit(value: hours, label: "HR")
                separator
            }
            timeUnit(value: minutes, label: "MIN")
            separator
            timeUnit(value: seconds, label: "SEC")
        }
    }
     
    private func timeUnit(value: Int, label: String) -> some View {
        VStack(spacing: 6) {
            Text(String(format: "%02d", value))
                .font(.largeTitle)
                .monospacedDigit()
                .foregroundStyle(.primary)
            
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .kerning(1.5)
        }
        .padding(.horizontal, 16)
        .frame(minWidth: 64)
    }
    
    private var separator: some View {
        Text(":")
            .font(.largeTitle)
            .foregroundStyle(.secondary)
            .padding(.bottom, 20)
    }
    
    // MARK: Buttons
    @ViewBuilder
    private var buttonRow: some View {
        switch timerState {
        case .idle:
            TimerControlButtonView(
                timerViewModel: TimerViewModel(activity: ActivityModel(id: UUID(), title: "", duration: duration)),
                state: .start,
                label: "Start",
                icon: "play.fill",
                tint: .blue
            )
        case .running:
            HStack(spacing: 16) {
                TimerControlButtonView(
                    timerViewModel: TimerViewModel(activity: ActivityModel(id: UUID(), title: "", duration: duration)),
                    state: .stop,
                    label: "Stop",
                    icon: "stop.fill",
                    tint: .red
                )
                TimerControlButtonView(
                    timerViewModel: TimerViewModel(activity: ActivityModel(id: UUID(), title: "", duration: duration)),
                    state: .pause,
                    label: "Pause",
                    icon: "pause.fill",
                    tint: .orange
                )
            }
        case .paused:
            HStack(spacing: 16) {
                TimerControlButtonView(
                    timerViewModel: TimerViewModel(activity: ActivityModel(id: UUID(), title: "", duration: duration)),
                    state: .stop,
                    label: "Stop",
                    icon: "stop.fill",
                    tint: .red
                )
                TimerControlButtonView(
                    timerViewModel: TimerViewModel(activity: ActivityModel(id: UUID(), title: "", duration: duration)),
                    state: .resume,
                    label: "Resume",
                    icon: "play.fill",
                    tint: .green
                )
            }
        case .completed:
            TimerControlButtonView(
                timerViewModel: TimerViewModel(activity: ActivityModel(id: UUID(), title: "", duration: duration)),
                state: .start,
                label: "Done",
                icon: "play.fill",
                tint: .indigo
            )
        }
    }
}

// MARK: - Previews
#Preview("Idle") {
    TimerScreenView(
        duration: 17400,
        remaining: 17400,
        timerState: .idle
    )
}
 
#Preview("Running") {
    TimerScreenView(
        duration: 17400,
        remaining: 14400,
        timerState: .running
    )
}
 
#Preview("Paused") {
    TimerScreenView(
        duration: 17400,
        remaining: 14400,
        timerState: .paused
    )
}
 
#Preview("Under 1 hour — hides HR") {
    TimerScreenView(
        duration: 300,
        remaining: 290,
        timerState: .running
    )
}
 
