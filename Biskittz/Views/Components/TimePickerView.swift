//
//  TimePickerView.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 17/06/26.
//

import SwiftUI

struct TimerPickerView: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int

    private let hours   = Array(0...23)   // 0 – 23 h
    private let minutes = Array(0...59)   // 0 – 59 min

    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                pickerDrum
                summaryLabel
            }
        }
    }

    // MARK: - Sub-views

    // Complete time picker
    var pickerDrum: some View {
        ZStack {
            HStack(spacing: 0) {
                // Hours column
                pickerColumn(
                    selection: $selectedHour,
                    values: hours,
                    label: "hour"
                )

                // Minutes column
                pickerColumn(
                    selection: $selectedMinute,
                    values: minutes,
                    label: "min"
                )
            }
        }
        .frame(height: 216)
    }
    
    // Columns to place the position labels next to picker value
    private let columns = [
        GridItem(.flexible(), spacing: 36),
        GridItem(.flexible(), spacing: 36)
    ]

    // Single picker wheel colum
    private func pickerColumn(selection: Binding<Int>, values: [Int], label: String) -> some View {
        VStack(spacing: 0) {
            ZStack() {
                LazyVGrid(columns: columns) {
                    VStack {
                        Text("")
                    }
                    
                    VStack {
                        Text(label)
                            .padding(.vertical, 8)
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
//                HStack {
//                    VStack {
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    
//                    Spacer(minLength: 36)
//                    
//                    VStack {
//                        Text(label)
//                            .padding(.vertical, 8)
//                            .font(.headline)
//                            .foregroundStyle(.primary)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(Color.red.opacity(0.08))
//                }
//                .frame(maxWidth: .infinity)
//                .background(Color.blue.opacity(0.08))
                
                Picker("Test", selection: selection) {
                    ForEach(values, id: \.self) { value in
                        Text(String(format: "%02d", value))
                            .padding(.vertical, 8)
                            .font(.title2)
                            .foregroundStyle(.primary)
                            .tag(value)
                    }
                }
                .pickerStyle(.wheel)
                .frame(maxWidth: .infinity)
                .clipped()
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
            }
        }
    }

    // Current selection
    @ViewBuilder
    var summaryLabel: some View {
        let h = selectedHour
        let m = selectedMinute

        if h == 0 && m == 0 {
            Text("Pick a duration above")
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.35))
        } else {
            HStack(spacing: 4) {
                if h > 0 {
                    Text("\(h) hr ")
                        .foregroundStyle(.blue)
                        .bold()
                }
                if m > 0 {
                    Text("\(m) min")
                        .foregroundStyle(.blue)
                        .bold()
                }
            }
            .font(.subheadline)
            .fontWeight(.medium)
        }
    }
}

// MARK: - Preview
#Preview {
    struct TimerPickerPreview: View {
        @State private var selectedHour: Int = 0
        @State private var selectedMinute: Int = 0
        
        var body: some View {
            TimerPickerView(selectedHour: $selectedHour, selectedMinute: $selectedMinute)
        }
    }
    return TimerPickerPreview()
}
