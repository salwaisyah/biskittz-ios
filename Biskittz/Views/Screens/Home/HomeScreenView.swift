//
//  HomeScreenView.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 13/06/26.
//

import SwiftUI

struct HomeScreenView: View {
    @State var activityViewModel: ActivityListViewModel = ActivityListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if activityViewModel.activities.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "cat")
                            .font(.system(size: 48))
                            .foregroundColor(.gray.opacity(0.8))
                        Text("No activities yet")
                            .font(.body)
                            .foregroundColor(.gray)
                        Text("Start an activity and let Mr. Biskittz handle the kneading while you handle the work.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else {
                    ScrollView {
                        HStack (spacing: 15) {
                            Circle()
                                .frame(width: 46, height: 46)
                                .foregroundStyle(Color.white)
                            
                            VStack (alignment: .leading) {
                                Text("Ready to focus?")
                                    .font(.title2)
                                    .bold()
                                
                                Text("Pick an activity and Mr. Biskittz will start kneading while you work.")
                                    .font(.subheadline)
                            }
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(Color.white)
                        
                        LazyVStack(spacing: 12) {
                            ForEach(activityViewModel.activities) { activity in
                                ActivityCardView(item: activity)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: Handle add action
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}


#Preview("With Data") {
    let vm = ActivityListViewModel()
    vm.activities = [
        ActivityModel(title: "Study SwiftUI: State & Binding", duration: 300),
        ActivityModel(title: "Grind for HiFi Design", duration: 600)
    ]
    
    return HomeScreenView(activityViewModel: vm)
}

#Preview("Empty State") {
    HomeScreenView()
}
