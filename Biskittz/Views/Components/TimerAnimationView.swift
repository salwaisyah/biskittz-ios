//
//  TimerAnimationView.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 21/06/26.
//

import SwiftUI
import Lottie

struct TimerAnimationView: View {
    let timerState: TimerState
        
    var body: some View {
        LottieView(animation: .named(timerState.animationName))
            .playing(loopMode: .autoReverse)
            .frame(width: 200, height: 200)
    }
}

#Preview {
    TimerAnimationView(timerState: .idle)
    TimerAnimationView(timerState: .running)
    TimerAnimationView(timerState: .paused)
    TimerAnimationView(timerState: .completed)
}
