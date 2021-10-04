//
//  RevisionVerbViewModel.swift
//  German
//
//  Created by Lauriane Mollier on 10/2/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import UIKit
import AVFoundation

// swiftUI having a ObservableObject in a ObservableObject
// https://stackoverflow.com/questions/62824472/swiftui-is-it-ok-to-put-an-observableobject-inside-another-observableobject

// https://rhonabwy.com/2021/02/13/nested-observable-objects-in-swiftui/
final class ReviewVerbViewModel: ObservableObject {
    
    @Binding var navigationState: RevisionNavigationState?
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    private var nbrVerbInReviewSession = 10
    @Published var isLoading: Bool
    
    @Published var index: Int
    @Published var currentLearningVerb: LearningVerb?
    @Published private var verbsToReview: [LearningVerb]
    @Published private var resultVerbsReviewed: [LearningVerb]
    
    @Published var audioEnable: Bool
    private var audioPlayer: AVAudioPlayer?
    
    init(navigationState: Binding<RevisionNavigationState?>) {
        self._navigationState = navigationState
        self.isLoading = true
        self.index = 0
        self.resultVerbsReviewed = []
        self.verbsToReview = []
        self.audioEnable = Audio.shared.isOn()
    }
    
    // -----------------
    // MARK: - Load verb
    // -----------------

    func getVerbToReview() {
        isLoading = true
        
        do {
            self.index = 0
            self.resultVerbsReviewed = []
            self.audioEnable = Audio.shared.isOn()
//            self.verbsToReview = try DAO.shared.verbToReviewToday(limit: 10)
            self.verbsToReview = [LearningVerb(id: 0, verb: Verbs.verbs[0]), LearningVerb(id: 1, verb: Verbs.verbs[1])]
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
    
    // -------------
    // MARK: - Audio
    // -------------
    
    private func toggleAudio() {
        if(Audio.shared.isOn()){
            audioEnable = false
            Audio.shared.off()
            audioStop()
        }
        else{
            audioEnable = true
            Audio.shared.on()
        }
    }
    
    
    // ---------------
    // MARK: - Private
    // ---------------
    
    // -----------------------------
    // MARK: - Private - review verb
    // -----------------------------
    
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
        audioStop()
        
        self.resultVerbsReviewed.append(updatedVerbReviewed)
        self.index += 1
        
        // End of the revision session
        if self.index >= self.verbsToReview.count{
            try endRevisionSession()
        }
        else{
//            self.flashcard.flipped = false
            self.currentLearningVerb = self.verbsToReview[self.index]
        }
    }
    
    private func endRevisionSession() throws {
        let dbResultVerbsReviewed = resultVerbsReviewed.map({ $0.toDbUserLearningVerb()})
        _ = try DAO.shared.update(learningVerbs: dbResultVerbsReviewed)
        navigationState = RevisionNavigationState.home
    }
    
    // -----------------------
    // MARK: - Private - audio
    // -----------------------
    
    private func audioPlay(verb: Verb) throws {
        let formatAudio = "mp3"
        let nameAudioFile = verb.temps.infinitive.value
        let audioURL = URL(fileURLWithPath: Bundle.main.path(forResource: nameAudioFile, ofType: formatAudio)!)
        audioPlayer = try AVAudioPlayer(contentsOf: audioURL, fileTypeHint: nil)
        audioPlayer!.play()
        audioPlayer!.numberOfLoops = 0
        
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
    }
    
    
    private func audioStop(){
        if audioPlayer != nil && audioPlayer!.isPlaying{
            audioPlayer!.stop()
        }
    }
}
