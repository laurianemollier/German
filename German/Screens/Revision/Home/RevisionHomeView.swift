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
    
    struct State: Equatable {
        var isLoading = false
        var alertItem: AlertItem?
        
        /// Determine number of verb that the user will review in one review session
        let nbrVerbInReviewSession = 10
        
        var verbToReviewTodayCount: String
        var verbInReviewListText: String

        var isRevisionDisabled: Bool = false
    }
    
    @EnvironmentObject var navigation: RevisionNavigationModel
    var store: Store<RevisionHomeState, RevisionHomeAction>
    @ObservedObject var viewStore: ViewStore<State, RevisionHomeAction>
    
    init (store: Store<RevisionHomeState, RevisionHomeAction>) {
        self.store = store
        self.viewStore = ViewStore (
            self.store.scope(state: State.init)
        )
    }
    
    var body: some View {
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
                                
                                Text(viewStore.verbToReviewTodayCount)
                                    .font(.largeTitle)
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(.white)
                                    .background(Color.brandPrimary)
                                    .clipShape(Circle())
                                
                            }
                        })
                        .disabled(viewStore.isRevisionDisabled)
                    
                    Text(viewStore.verbInReviewListText)
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
                    viewStore.send(.loadState)
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
    
    private func revisionSessionView() -> RevisionSessionView {
        RevisionSessionView(
            store: Store(
                initialState: RevisionSessionState(),
                reducer: revisionSessionReducer,
                environment: ())
        )
    }
    
}

extension RevisionHomeView.State {
    init(state: RevisionHomeState) {
        self.isLoading = state.isLoading
        self.alertItem = state.alertItem
        
        self.verbToReviewTodayCount =  state.verbToReviewTodayCount.map({String($0)}) ?? "--"
        self.verbInReviewListText = "Verbs to review over \(state.verbInReviewListCount.map({String($0)}) ?? "--") in your review list"
        
        if let count = state.verbToReviewTodayCount {
            self.isRevisionDisabled = count <= 0
        } else {
            self.isRevisionDisabled = false
        }
    }
}
