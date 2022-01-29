//
//  LearnVerbView.swift
//  German
//
//  Created by Lauriane Mollier on 29.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct LearnVerbView: View {
    
    var store: Store<LearnVerbState, LearnVerbAction>
    @ObservedObject var viewStore: ViewStore<LearnVerbState, LearnVerbAction>
    
    init(store: Store<LearnVerbState,LearnVerbAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        VStack {
            Text("Learn a view verb")
            Spacer()
            
            switch(viewStore.tenseDiscoveryState) {
            case .start:
                learnTenseCard(
                    verbTense: viewStore.verb.tense.infinitive,
                    translation: viewStore.verb.translation(Lang.en),
                    tenseHelper: "(Infinitive)",
                    action: .infinitiveFormSeen
                )
                
            case .infinitiveFormSeen:
                learnTenseCard(
                    verbTense: viewStore.verb.tense.present,
                    translation: viewStore.verb.translation(Lang.en),
                    tenseHelper: "(Present)",
                    action: .presentFormSeen
                )
                
            case .presentFormSeen:
                learnTenseCard(
                    verbTense: viewStore.verb.tense.simplePast,
                    translation: viewStore.verb.translation(Lang.en),
                    tenseHelper: "(Simple past)",
                    action: .simplePastFormSeen
                )
                
            case .simplePastFormSeen:
                learnTenseCard(
                    verbTense: viewStore.verb.tense.pastParticiple,
                    translation: viewStore.verb.translation(Lang.en),
                    tenseHelper: "(Past Participle)",
                    action: .pastParticipleFormSeen
                )
                
            case .allFormSeen:
                Spacer()
                Text("Verb added in you review list !")
                Spacer()
            }
        }
    }
    
    private func learnTenseCard(
        verbTense: VerbTense,
        translation: String,
        tenseHelper: String,
        action: LearnVerbAction) -> some View {
            return VStack {
                Spacer()
                VStack {
                    Text.verbTemps(verbTense)
                        .fontWeight(.bold)
                    Text(translation)
                    Text(tenseHelper)
                        .font(.subheadline)
                }
                Spacer()
                Button { viewStore.send(action) } label: {
                    Text("Ok")
                }
            }
        }
}

struct LearnVerbView_Previews: PreviewProvider {
    static var previews: some View {
        LearnVerbView(
            store: Store.init(
                initialState: LearnVerbState.init(
                    verb: Verbs.verbs.first!,
                    tenseDiscoveryState: .start
                ),
                reducer: learnVerbReducer,
                environment: ()
            )
        )
    }
}
