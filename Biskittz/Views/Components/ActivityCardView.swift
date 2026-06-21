//
//  ActivityCardView.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 13/06/26.
//

import SwiftUI

struct ActivityCardView: View {
    var item: ActivityModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 12){
            Text(item.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
            
            HStack {
                Text(DurationFormatter.formattedDuration(for: item.duration))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                    
                Text("\(item.sessionCount) sessions completed")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.08))
                .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 4)
        )
        .glassEffect(.clear, in: .rect(cornerRadius:12))
    }
}

#Preview {
    // Create an activity id first to feed both Activity and Sessions
    let activityId = UUID()
    let activity = ActivityModel(
        id: activityId,
        title: "Study SwiftUI: State & Binding",
        duration: 300,
        sessions: [
            SessionModel(activityId: activityId),
            SessionModel(activityId: activityId),
            SessionModel(activityId: activityId)
        ]
    )
    return ActivityCardView(item: activity)
}
