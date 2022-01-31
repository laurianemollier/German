//
//  VerbDetailsReducer.swift
//  German
//
//  Created by Lauriane Mollier on 30.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture



// Cannot convert value of type 'WritableKeyPath<VerbDetailsState, VerbDetailsState.DetailType>' to expected argument type 'WritableKeyPath<VerbDetailsState, LearnVerbState>'

//let w: WritableKeyPath<VerbDetailsState, VerbDetailsState.DetailType> = \VerbDetailsState.detailType

//let w: WritableKeyPath<VerbDetailsState, LearnVerbState?> =
//\switch(VerbDetailsState.detailType) {
//case .learn(let state): state
//}

let verbDetailReducer = Reducer<VerbDetailState, VerbDetailAction, ()>.combine(
    learnVerbReducer
        .optional()
        .pullback(
            state: \VerbDetailState.learnVerb,
            action: /VerbDetailAction.learnVerb,
            environment: {_ in ()}
        ),
    verbProgressionDetailReducer
        .optional()
        .pullback(
            state: \VerbDetailState.verbProgressionDetail,
            action: /VerbDetailAction.verbProgression,
            environment: {_ in ()}
        )
    
)
