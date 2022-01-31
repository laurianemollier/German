//
//  VerbDetailState.swift
//  German
//
//  Created by Lauriane Mollier on 30.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

struct VerbDetailState: Equatable {
    // TODO: lolo
    var learningVerb: LearningVerb
    // either verbProgressionDetail is set, either learnVerb. Not both.
////     TODO: fix that. Ex with syntax:
//        enum DetailType: Equatable {
//            case progression(VerbProgressionDetailState)
//            case learn(LearnVerbState)
//        }
//        var detailType: DetailType
//
//
//
    
//    var counter: CounterAction? {
//      get {
//        guard case let .counter(value) = self else { return nil }
//        return value
//      }
//      set {
//        guard case .counter = self, let newValue = newValue else { return }
//        self = .counter(newValue)
//      }
//    }
    
    var verbProgressionDetail: VerbProgressionDetailState?
    var learnVerb: LearnVerbState?

    init(verbProgressionDetail learningVerb: LearningVerb) {
        self.learningVerb = learningVerb
        self.verbProgressionDetail = VerbProgressionDetailState(learningVerb: learningVerb)
        self.learnVerb = nil
    }

    init(learnVerb learningVerb: LearningVerb) {
        self.learningVerb = learningVerb
        self.verbProgressionDetail = nil
        self.learnVerb = LearnVerbState(learningVerb: learningVerb)
    }
}


//extension VerbDetailState.DetailType {
////    WritableKeyPath<VerbDetailsState, LearnVerbState?>
//    func verbProgressionDetail() -> VerbProgressionDetailState? {
//        switch(self) {
//        case .progression(let state):
//            return state
//        case .learn:
//            return nil
//        }
//    }
//}
