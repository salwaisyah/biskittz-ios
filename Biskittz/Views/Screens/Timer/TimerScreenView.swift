//
//  TimerScreenView.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 18/06/26.
//

import SwiftUI

// MARK: - Main Screen
struct TimerScreenView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ActivityListViewModel.self) var activityViewModel
    
    @State var timerViewModel: TimerViewModel
    
    let activity: ActivityModel
    
    init(activity: ActivityModel) {
        
        self.activity = activity

        _timerViewModel = State(
            initialValue: TimerViewModel(
                activity: activity
            )
        )
    }
    
    // MARK: Derived
    private var progress: Double {
        guard timerViewModel.timeDuration > 0 else { return 0 }
        return Double(timerViewModel.timeRemaining) / Double(timerViewModel.timeDuration)
    }
    
    private var hours: Int   { timerViewModel.timeRemaining / 3600 }
    private var minutes: Int { (timerViewModel.timeRemaining % 3600) / 60 }
    private var seconds: Int { timerViewModel.timeRemaining % 60 }
    private var showHours: Bool { timerViewModel.timeDuration >= 3600 }
     
    // MARK: Body
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text(timerViewModel.activity.title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
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
        .onAppear {
            print("TIMER VM:", ObjectIdentifier(activityViewModel))
        }
        .onChange(of: timerViewModel.timerState) { oldState, newState in
            if newState == .completed {
                activityViewModel.logSession(activityID: timerViewModel.activity.id)
            }
        }
        
    }
    
    // MARK: ringSection
    private var ringSection: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let ringRadius = size * 0.42
            let lineWidth: CGFloat = 14
            
            ZStack {
                // Track
                Circle()
                    .stroke(Color(.systemGray4), lineWidth: lineWidth)
                
                // Progress arc
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.brown,
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
                

                tipDot(ringRadius: ringRadius, lineWidth: lineWidth)
                
                TimerAnimationView(timerState: timerViewModel.timerState)

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
        switch timerViewModel.timerState {
        case .idle:
            TimerControlButtonView(state: .startButton){
                timerViewModel.start()
            }
        case .running:
            HStack(spacing: 16) {
                TimerControlButtonView(state: .stopButton){
                    timerViewModel.stop()
                }
                TimerControlButtonView(state: .pauseButton){
                    timerViewModel.pause()
                }
            }
        case .paused:
            HStack(spacing: 16) {
                TimerControlButtonView(state: .stopButton){
                    timerViewModel.stop()
                }
                TimerControlButtonView(state: .resumeButton){
                    timerViewModel.start()
                }
            }
        case .completed:
            TimerControlButtonView(state: .completeButton){
                dismiss()
            }
        }
    }
}

// MARK: - Previews
#Preview("Timer Screen") {
    let vm = ActivityListViewModel()
    
    TimerScreenView(
        activity: ActivityModel(title: "Study SwiftUI", duration: 10)
    )
    .environment(vm)
}

//#Preview("Idle") {
//    TimerScreenView(
//        duration: 17400,
//        remaining: 17400,
//        timerState: .idle
//    )
//}
// 
//#Preview("Running") {
//    TimerScreenView(
//        duration: 17400,
//        remaining: 14400,
//        timerState: .running
//    )
//}
// 
//#Preview("Paused") {
//    TimerScreenView(
//        duration: 17400,
//        remaining: 14400,
//        timerState: .paused
//    )
//}
// 
//#Preview("Under 1 hour — hides HR") {
//    TimerScreenView(
//        duration: 300,
//        remaining: 290,
//        timerState: .running
//    )
//}
 
