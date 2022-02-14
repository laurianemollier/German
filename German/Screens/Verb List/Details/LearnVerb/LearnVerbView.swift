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
                    verbTense: viewStore.learningVerb.verb.tense.infinitive,
                    translation: viewStore.learningVerb.verb.translation(Lang.en),
                    tenseHelper: "(Infinitive)",
                    action: .infinitiveFormSeen
                )
                
            case .infinitiveFormSeen:
                learnTenseCard(
                    verbTense: viewStore.learningVerb.verb.tense.present,
                    translation: viewStore.learningVerb.verb.translation(Lang.en),
                    tenseHelper: "(Present)",
                    action: .presentFormSeen
                )
                
            case .presentFormSeen:
                learnTenseCard(
                    verbTense: viewStore.learningVerb.verb.tense.simplePast,
                    translation: viewStore.learningVerb.verb.translation(Lang.en),
                    tenseHelper: "(Simple past)",
                    action: .simplePastFormSeen
                )
                
            case .simplePastFormSeen:
                learnTenseCard(
                    verbTense: viewStore.learningVerb.verb.tense.pastParticiple,
                    translation: viewStore.learningVerb.verb.translation(Lang.en),
                    tenseHelper: "(Past Participle)",
                    action: .pastParticipleFormSeen
                )
                
            case .allFormSeen:
                Text("Verb added in you review list !")
                Spacer()
                Button { viewStore.send(.endLearnSession) } label: {
                    Text("Ok")
                }
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
