//
//  RevisionVerbViewModel.swift
//  German
//
//  Created by Lauriane Mollier on 10/2/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

// swiftUI having a ObservableObject in a ObservableObject
// https://stackoverflow.com/questions/62824472/swiftui-is-it-ok-to-put-an-observableobject-inside-another-observableobject

// https://rhonabwy.com/2021/02/13/nested-observable-objects-in-swiftui/
final class ReviewVerbViewModel: ObservableObject {
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    private var nbrVerbInReviewSession = 10
    @Published var isLoading: Bool
    
    @Published var index: Int
    @Published var currentLearningVerb: LearningVerb?
    @Published var verbsToReview: [LearningVerb]
    @Published private var resultVerbsReviewed: [LearningVerb]
    
    private var actionOnNextVerb: () -> Void = {}
    private var actionOnEndRevisionSession: () -> Void = {}
    
    // ------------
    // MARK: - Init
    // ------------
    
    init() {
        self.isLoading = true
        self.index = 0
        self.resultVerbsReviewed = []
        self.verbsToReview = []
    }
    
    func setAction(onNextVerb: @escaping () -> Void) {
        self.actionOnNextVerb = onNextVerb
    }
    
    func setAction(onEndRevisionSession: @escaping () -> Void) {
        self.actionOnEndRevisionSession = onEndRevisionSession
    }
    
    // -----------------
    // MARK: - Load verb
    // -----------------

    func getVerbToReview() {
        isLoading = true
        
        do {
            self.verbsToReview = try DAO.shared.verbToReviewToday(limit: 10)
            self.currentLearningVerb = self.verbsToReview[index] // TODO: could cause error
            isLoading = false
        }
        catch {
            SpeedLog.print(error)
        }
        
        // TODO: lolo
        //        NetworkManager.shared.getAppetizers { [self] result in
        //            DispatchQueue.main.async {
        //                isLoading = false
        //                switch result {
        //                case .success(let appetizers):
        //                    self.appetizers = appetizers
        //
        //                case .failure(let error):
        //                    switch error {
        //                    case .invalidResponse:
        //                        alertItem = AlertContext.invalidResponse
        //
        //                    case .invalidURL:
        //                        alertItem = AlertContext.invalidURL
        //
        //                    case .invalidData:
        //                        alertItem = AlertContext.invalidData
        //
        //                    case .unableToComplete:
        //                        alertItem = AlertContext.unableToComplete
        //                    }
        //                }
        //            }
        //        }
    }
    
    // -------------------
    // MARK: - Review verb
    // -------------------
    
    func regress() throws {
        if let currentReviewDate = currentLearningVerb?.dateToReview,
           let (newProgression, toReviewDate) = currentLearningVerb?.userProgression.regression(reviewedDate: currentReviewDate){
            try verbReviewedAction(newProgression: newProgression, toReviewDate: toReviewDate)
        } else {
            SpeedLog.print("TODO throw error")
        }
    }
    
    func stagnate() throws {
        if let currentReviewDate = currentLearningVerb?.dateToReview,
           let (newProgression, toReviewDate) = currentLearningVerb?.userProgression.stagnation(reviewedDate: currentReviewDate){
            try verbReviewedAction(newProgression: newProgression, toReviewDate: toReviewDate)
        } else {
            SpeedLog.print("TODO throw error")
        }
    }
    
    func progress() throws {
        if let currentReviewDate = currentLearningVerb?.dateToReview,
           let (newProgression, toReviewDate) = currentLearningVerb?.userProgression.progression(reviewedDate: currentReviewDate){
            try verbReviewedAction(newProgression: newProgression, toReviewDate: toReviewDate)
        } else {
            SpeedLog.print("TODO throw error")
        }
    }
    
    // ---------------
    // MARK: - Private
    // ---------------
    
    private func verbReviewedAction(newProgression: UserProgression, toReviewDate: Date) throws {
        if let currentVerb = currentLearningVerb {
            let updatedVerbReviewed = LearningVerb(id: currentVerb.id,
                                                   verb: currentVerb.verb,
                                                   dateToReview: toReviewDate,
                                                   userProgression: newProgression)
            try nextVerb(updatedVerbReviewed: updatedVerbReviewed)
        }
        else {
            SpeedLog.print("TODO throw error")
        }
    }
    
    private func nextVerb(updatedVerbReviewed: LearningVerb) throws {
        self.resultVerbsReviewed.append(updatedVerbReviewed)
        self.index += 1
        
        // End of the revision session
        if self.index >= self.verbsToReview.count{
            try endRevisionSession()
        }
        else{
            actionOnNextVerb()
            self.currentLearningVerb = self.verbsToReview[self.index]
        }
    }
    
    private func endRevisionSession() throws {
        let dbResultVerbsReviewed = resultVerbsReviewed.map({ $0.toDbUserLearningVerb()})
        actionOnEndRevisionSession()
        _ = try DAO.shared.update(learningVerbs: dbResultVerbsReviewed)
       
    }
}
