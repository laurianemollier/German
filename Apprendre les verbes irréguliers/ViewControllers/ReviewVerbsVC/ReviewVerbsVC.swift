//
//  ReviewVerbsVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/07/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import UIKit

class ReviewVerbsVC: UIViewController {

    var index: Int = 0
    var verbsToReview: [UserLearningVerb]!
    var resultVerbsReviewed: [UserLearningVerb] = []

    var forwardCardVC: ForwarCardVC!
    var backwardCardVC: BackwardCardVC!
    
    

    var isCardForward: Bool!
    
    @IBOutlet weak var forwarCard: UIView!
    
    @IBOutlet weak var backwardCard: UIView!
    
    @IBOutlet weak var buttonOnCard: UIButton!
    
    @IBOutlet weak var realButtonOutsideCard: UIButton!

    @IBOutlet weak var progressionLabel: UILabel!
    
    @IBOutlet weak var explainationLabel: UILabel!
    
    @IBOutlet weak var regressionButton: BasicButton!
    @IBOutlet weak var stagnationButton: BasicButton!
    @IBOutlet weak var progressionButton: BasicButton!
    @IBOutlet weak var neverReviewButton: BasicButton!
    
    
    @IBAction func back(_ sender: UIButton) {
        back()
    }
    
    
    @IBAction func revealClickButton(_ sender: UIButton) {
        revealCard(sender)
    }
    @IBAction func revealClickOnCard(_ sender: UIButton) {
        revealCard(sender)
    }
    
    @IBAction func regress(_ sender: BasicButton) {
        let verbReviewed: UserLearningVerb = currentVerb()
        let (newProgression, dateToReview) = verbReviewed.userProgression.regression(reviewedDate: verbReviewed.dateToReview!)!
        updatedVerbReviewed(newProgression: newProgression, dateToReview: dateToReview)
    }
    @IBAction func stagnate(_ sender: BasicButton) {
        let verbReviewed: UserLearningVerb = currentVerb()
        let (newProgression, dateToReview) = verbReviewed.userProgression.stagnation(reviewedDate: verbReviewed.dateToReview!)!
        updatedVerbReviewed(newProgression: newProgression, dateToReview: dateToReview)
        
    }
    @IBAction func progress(_ sender: BasicButton) {
        let verbReviewed: UserLearningVerb = currentVerb()
        let (newProgression, dateToReview) = verbReviewed.userProgression.progression(reviewedDate: verbReviewed.dateToReview!)!
        updatedVerbReviewed(newProgression: newProgression, dateToReview: dateToReview)
    }

    private func currentVerb() -> UserLearningVerb{
        return self.verbsToReview[self.index]
    }
    
    private func updatedVerbReviewed(newProgression: UserProgression, dateToReview: Date?){
        let verbReviewed: UserLearningVerb = currentVerb()
        let updatedVerbReviewed = UserLearningVerb(id: verbReviewed.id,
                                                   verb: verbReviewed.verb,
                                                   dateToReview: dateToReview,
                                                   userProgression: newProgression)
        
        nextVerb(updatedVerbReviewed: updatedVerbReviewed)
    }
    
    

    @IBAction func toNeverReview(_ sender: BasicButton) {
        updatedVerbReviewed(newProgression: UserProgression.toIgnore, dateToReview: nil)
    }
    
    private func nextVerb(updatedVerbReviewed: UserLearningVerb?){
        if let v = updatedVerbReviewed {
            self.resultVerbsReviewed.append(v)
        }
        self.index += 1
        
        // End of the revision session
        if self.index >= self.verbsToReview.count{
            endRevisionSession()
        }
        else{
            resetCard(verb: self.verbsToReview[self.index].verb)
        }
    }
    
    
    
    
    

    private func flipCard(visible: UIView, notVisibleYet: UIView){
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: visible, duration: 1.0, options: transitionOptions, animations: {
            visible.isHidden = true
        })
        
        UIView.transition(with: notVisibleYet, duration: 1.0, options: transitionOptions, animations: {
            notVisibleYet.isHidden = false
        })
        
        self.isCardForward = !self.isCardForward
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resetCard(verb: self.verbsToReview[self.index].verb)
    }
    
    @objc private func cancelTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forwardCardSegue"{
            self.forwardCardVC = segue.destination as! ForwarCardVC
        }
        else if segue.identifier == "backCardSegue"{
            self.backwardCardVC = segue.destination as! BackwardCardVC
        }
    }
    
    private func revealCard(_ sender: UIButton){
        if self.isCardForward{
            flipCard(visible: self.forwarCard, notVisibleYet: self.backwardCard)
            self.isCardForward = false
            AudioReader.play(verb: self.currentVerb().verb)
        }
        else{
            flipCard(visible: self.backwardCard, notVisibleYet: self.forwarCard)
            self.isCardForward = true
            
        }
        
        
        self.realButtonOutsideCard.isHidden = true
        
        self.explainationLabel.isHidden = false
        self.regressionButton.isHidden = false
        self.stagnationButton.isHidden = false
        self.progressionButton.isHidden = false
//        self.neverReviewButton.isHidden = false
        
        let progression = self.currentVerb().userProgression
        self.regressionButton.setTitle(progression.regressionName(), for: .normal)
        self.stagnationButton.setTitle(progression.stagnationName(), for: .normal)
        self.progressionButton.setTitle(progression.progressionName(), for: .normal)
        
    }
    
    
    private func resetCard(verb: Verb){
        self.isCardForward = true
        self.forwarCard.isHidden = false
        self.backwardCard.isHidden = true
        
        self.realButtonOutsideCard.isHidden = false
        
        self.explainationLabel.isHidden = true
        self.regressionButton.isHidden = true
        self.stagnationButton.isHidden = true
        self.progressionButton.isHidden = true
//        self.neverReviewButton.isHidden = true
        
        self.forwardCardVC.reset(verb: verb)
        
        // Set the data in for the back of the car
        self.backwardCardVC.reset(verb: verb)
        
        
        // Progression label
        self.progressionLabel.text = textProgressionLabel()
    }
    
    
    private func endRevisionSession(){
        let dbResultVerbsReviewed = resultVerbsReviewed.map({ $0.toDbUserLearningVerb()})
        do{
            let results: [Int] = try DbUserLearningVerbDAOImpl.shared.update(learningVerbs: dbResultVerbsReviewed)
            if results.forAll(where: {$0 > 0})  {
                back()
                // TODO: Show the success
                SpeedLog.print("Sucessly modify all learning verb")
            }
            else{
                // TODO
                SpeedLog.print("One verb was not found")
            }
        }
        catch{
            // TODO
            SpeedLog.print(error)
        }
    }
    
    
    private func textProgressionLabel() -> String {
        return String(self.index + 1) + "/" + String(self.verbsToReview.count)
    }
    
    private func back(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
 

}
