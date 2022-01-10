//
//  VerbDetailView.swift
//  German
//
//  Created by Lauriane Mollier on 03.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct VerbDetailView: View {
    
    var store: Store<VerbDetailState, VerbDetailAction>
    @ObservedObject var viewStore: ViewStore<VerbDetailState, VerbDetailAction>
    
    init(store: Store<VerbDetailState, VerbDetailAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        VStack {
            BackCardView(verb: viewStore.learningVerb.verb)
            
            if viewStore.learningVerb.userProgression == UserProgression.notSeenYet {
                Button { viewStore.send(.addToTheReviewList) } label: {
                    ToChangeButton(
                        title: "Add the verb to the review list",
                        backgroundColor: Color.orange)
                }
            } else {
                Text("Knowledge level for this verb")
                
                VStack{
                    userProgressionButton(userProgression: UserProgression.level1)
                    userProgressionButton(userProgression: UserProgression.level2)
                    userProgressionButton(userProgression: UserProgression.level3)
                    userProgressionButton(userProgression: UserProgression.level4)
                    userProgressionButton(userProgression: UserProgression.level5)
                    userProgressionButton(userProgression: UserProgression.level6)
                    userProgressionButton(userProgression: UserProgression.level7)
                    userProgressionButton(userProgression: UserProgression.level8)
                }
            }
        }
    }
    
    private func userProgressionButton(userProgression: UserProgression) -> Button<UserProgressionButton> {
        return Button { viewStore.send(.selectNewProgressionLevel(userProgression)) } label: {
            UserProgressionButton(userProgression: userProgression)
        }
    }
}
