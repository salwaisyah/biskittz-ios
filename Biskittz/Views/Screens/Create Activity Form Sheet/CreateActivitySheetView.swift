//
//  CreateActivitySheetView.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 13/06/26.
//

import SwiftUI

struct CreateActivitySheetView: View {
    @Binding var isShowingSheet: Bool
    @State private var title: String = ""
    @State private var duration: Int = 0
    
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    
    var activityViewModel: ActivityListViewModel
    
    var body: some View {
        NavigationStack {
            LazyVStack (alignment: .leading, spacing: 12) {
                titleField(label: "Title", text: $title)
                
                VStack() {
                    TimerPickerView(selectedHour: $hours, selectedMinute: $minutes)
                }
                .padding(.vertical, 12)
                
                Text("Presets")
                    .font(.title2)
                    .bold()
                
                ScrollView(.horizontal) {
                    LazyHStack (spacing: 12) {
                        PresetButton(preset: "5\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                        PresetButton(preset: "10\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                        PresetButton(preset: "15\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                        PresetButton(preset: "20\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                        PresetButton(preset: "25\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                        PresetButton(preset: "30\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                        PresetButton(preset: "40\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                        PresetButton(preset: "45\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                        PresetButton(preset: "50\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                        PresetButton(preset: "55\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                        PresetButton(preset: "59\nmin", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                        PresetButton(preset: "1\nhr", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                        PresetButton(preset: "2\nhr", duration: $duration, hours: $hours, minutes: $minutes, seconds: $seconds)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("New Activity")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isShowingSheet = false
                    } label: {
                        Image(systemName: "multiply")
                    }
                    .clipShape(Circle())
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        activityViewModel.addActivity(title: title, duration: duration)
                        isShowingSheet = false
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty || duration == 0)
                }
            }
            
        }
    }
    

    
}

// MARK: Functions for text fields (will be moved later)
private func titleField(label: String, text: Binding<String>) -> some View {
    TextField("Title", text: text)
        .font(.body)
        .fontWeight(.medium)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 64)
            .fill(Color(.tertiarySystemFill)))
}


// MARK: Previews
#Preview {
    @Previewable @State var isShowingSheet = true
    @Previewable @State var title = "hello"
    @Previewable @State var duration = 300
    
    CreateActivitySheetView(
        isShowingSheet: $isShowingSheet, activityViewModel: .init()
    )
}
