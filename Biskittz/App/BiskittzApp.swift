//
//  BiskittzApp.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 12/06/26.
//

import SwiftUI

@main
struct BiskittzApp: App {
    @State private var activityListViewModel = ActivityListViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeScreenView()
                .environment(activityListViewModel)
        }
    }
}
