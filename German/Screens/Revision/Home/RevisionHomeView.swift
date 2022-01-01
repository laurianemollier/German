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
    var store: Store<RevisionHomeState, RevisionHomeAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                ZStack{
                    VStack {
                        NavigationLink(
                            destination: revisionSessionView(),
                            isActive: $navigation.activeRevision,
                            label: {
                                ZStack(alignment: .bottom){
                                    Circle()
                                        .frame(width: 190, height: 190)
                                        .foregroundColor(.red)
                                        .opacity(0.6)
                                    
                                    Text(
                                        viewStore
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
                            .disabled(viewStore.isRevisionDisabled)
                        
                        Text("Verbs to review over \(viewStore.verbInReviewListCount.map({String($0)}) ?? "--") in your review list")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom, 60)
                        
                        NavigationLink(
                            destination: revisionSessionView(),
                            isActive: $navigation.activeRevision,
                            label: {CallToActionButton(title: "Review")}
                        ).disabled(viewStore.isRevisionDisabled)
                        
                        Spacer()
                    }
                    .onAppear() {
                        viewStore.send(.refreshState)
                    }
                    
                    if viewStore.isLoading {
                        LoadingView()
                    }
                }
            }
            .alert(item: .constant(viewStore.alertItem)) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.dismissText))
            }
        }
    }
    
    private func revisionSessionView() -> RevisionSessionView {
        RevisionSessionView(
            store: Store(
                initialState: ReviewVerbsFeatureState(),
                reducer: reviewVerbsFeatureReducer,
                environment: ())
        )
    }
    
}
