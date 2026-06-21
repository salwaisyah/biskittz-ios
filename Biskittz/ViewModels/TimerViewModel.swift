//
//  TimerViewModel.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 19/06/26.
//

import Foundation
import Observation

@Observable
class TimerViewModel {
    var activity: ActivityModel

    // Input
    var timeDuration: Int                   // total seconds
    var timeRemaining: Int                  // seconds left
    var timerState: TimerState = .idle      // time state (ex: paused = orange, idle = blue) - will be replaced with the real animation later

    private var timer: Timer?

    init(activity: ActivityModel) {
        self.activity = activity
        self.timeDuration = activity.duration
        self.timeRemaining = activity.duration
    }
    
    
    // Button function
    
    func start() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
        timerState = .running
        // start the countdown
    }
    
    func pause() {
        timerState = .paused
        timer?.invalidate()
        timer = nil
        // pause the countdown
    }
    
    func stop() {
        // action: pause the running time -> alert shows "Are you sure you want to stop?" -> if yes, reset the timer -> if no, close alert and show timer with paused state
        timer?.invalidate()
        timer = nil
        timerState = .idle
        timeRemaining = timeDuration // reset
    }
    
    func complete() {
        timerState = .completed
        timer?.invalidate()
        timer = nil
        // call activityListViewModel.logSession() from TimerScreenView
    }
    
    
    // Timer countdown
    private func tick() {
        if timeRemaining == 0 {
            complete()
        } else {
            timeRemaining -= 1            
        }
    }
}
