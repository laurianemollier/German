//
//  RevisionHomeView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RevisionHomeView: View {
    
    @EnvironmentObject var navigation: RevisionNavigationModel
    @ObservedObject var store: Store<RevisionHomeState, RevisionHomeAction>
    
    public init(store: Store<RevisionHomeState, RevisionHomeAction>) {
        self.store = store
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    NavigationLink(
                        destination: reviewVerbView(),
                        isActive: $navigation.activeRevision,
                        label: {
                            ZStack(alignment: .bottom){
                                Circle()
                                    .frame(width: 190, height: 190)
                                    .foregroundColor(.red)
                                    .opacity(0.6)
                                
                                Text(
                                    store
                                        .value
                                        .verbToReviewTodayCount
                                        .map({String($0)}) ?? "--"
                                )
                                    .font(.largeTitle)
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(.white)
                                    .background(Color.brandPrimary)
                                    .clipShape(Circle())
                                
                            }
                        })
                        .disabled(store.value.isRevisionDisabled)
                    
                    Text("Verbs to review over \(store.value.verbInReviewListCount.map({String($0)}) ?? "--") in your review list")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom, 60)
                    
                    NavigationLink(
                        destination: reviewVerbView(),
                        isActive: $navigation.activeRevision,
                        label: {CallToActionButton(title: "Review")}
                    ).disabled(store.value.isRevisionDisabled)
                    
                    Spacer()
                }
                .onAppear() {
                    store.send(.refreshState)
                }
                
                if store.value.isLoading {
                    LoadingView()
                }
            }
        }
        .alert(item: .constant(store.value.alertItem)) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
    
    private func reviewVerbView() -> ReviewVerbView {
        ReviewVerbView(
            store: Store(
                initialValue: ReviewVerbViewState(),
                reducer: ReviewVerbViewReducer)
        )
    }
    
}
