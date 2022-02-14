//
//  VerbDetailState.swift
//  German
//
//  Created by Lauriane Mollier on 30.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//


struct VerbDetailState: Equatable {
    enum DetailType: Equatable {
        case progression(VerbProgressionDetailState)
        case learn(LearnVerbState)
    }
    
    var detailType: DetailType
    
    init(verbProgressionDetail learningVerb: LearningVerb) {
        self.detailType = .progression(VerbProgressionDetailState(learningVerb: learningVerb))
    }
    
    init(learnVerb learningVerb: LearningVerb) {
        self.detailType = .learn(LearnVerbState(learningVerb: learningVerb))
    }
    
    
    // TODO: improve with https://www.pointfree.co/collections/enums-and-structs
    var verbProgressionDetail: VerbProgressionDetailState? {
        get {
            guard case let .progression(value) = self.detailType else { return nil }
            return value
        }
        set {
            guard case .progression = self.detailType, let newValue = newValue else { return }
            self.detailType = .progression(newValue)
        }
    }
    
    // TODO: improve with https://www.pointfree.co/collections/enums-and-structs
    var learnVerb: LearnVerbState? {
        get {
            guard case let .learn(value) = self.detailType else { return nil }
            return value
        }
        set {
            guard case .learn = self.detailType, let newValue = newValue else { return }
            self.detailType = .learn(newValue)
        }
    }
    
    // TODO: improve with https://www.pointfree.co/collections/enums-and-structs
    var learningVerb: LearningVerb {
        get {
            switch(detailType) {
            case let .progression(state):
                return state.learningVerb
            case let .learn(state):
                return state.learningVerb
            }
        }
        set {
            switch(detailType) {
            case .progression:
                self.detailType = .progression(VerbProgressionDetailState(learningVerb: newValue))
            case .learn:
                self.detailType = .learn(LearnVerbState(learningVerb: newValue))
            }
        }
    }
}
