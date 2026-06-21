//
//  HomeScreenView.swift
//  Biskittz
//
//  Created by Salwa Aisyah Adhani on 13/06/26.
//

import SwiftUI

struct HomeScreenView: View {
    @Environment(ActivityListViewModel.self) var activityViewModel
    @State var isShowingSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if activityViewModel.activities.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "questionmark.square")
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
                            ForEach(activityViewModel.activities, id: \.id) { activity in
                                NavigationLink(destination: TimerScreenView(
                                    activity: activity
                                )) {
                                    ActivityCardView(item: activity)
                                }
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
                        isShowingSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $isShowingSheet) {
                        CreateActivitySheetView(
                            isShowingSheet: $isShowingSheet,
                            activityViewModel: activityViewModel
                        )
                        .presentationDetents([.large])
                    }
                }
            }
            .onAppear {
                print("HOME VM:", ObjectIdentifier(activityViewModel))
            }
            .onChange(of: activityViewModel.activities) { _, _ in
                print("HOME: activities changed!")
            }
        }
    }
}


#Preview("Home - With Data") {
    let vm = ActivityListViewModel()

    let _ = vm.addActivity(title: "Study SwiftUI", duration: 5)
    let _ = vm.addActivity(title: "Read a Book", duration: 600)

    HomeScreenView()
        .environment(vm)
}

#Preview("Home - Empty State") {
    let vm = ActivityListViewModel()

    HomeScreenView()
        .environment(vm)
}
