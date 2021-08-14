//
//  VerbDetailsVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 10/10/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class VerbDetailsVC: UIViewController {
    
    var userLearningVerb: UserLearningVerb!
    
    
    // ------------------
    // MARK: - Outlets
    // ------------------
    
    @IBOutlet weak var verbNotInReviewCardView: UIView!
    @IBOutlet weak var verbNotInReviewButtonView: UIView!
    
    @IBOutlet weak var verbInReviewScrollView: UIScrollView!
    
    
    @IBOutlet weak var progressionLevel1: UserProgressionButton!
    @IBOutlet weak var progressionLevel2: UserProgressionButton!
    @IBOutlet weak var progressionLevel3: UserProgressionButton!
    @IBOutlet weak var progressionLevel4: UserProgressionButton!
    @IBOutlet weak var progressionLevel5: UserProgressionButton!
    @IBOutlet weak var progressionLevel6: UserProgressionButton!
    @IBOutlet weak var progressionLevel7: UserProgressionButton!
    @IBOutlet weak var progressionLevel8: UserProgressionButton!
    
    // ------------------
    // MARK: - Actions
    // ------------------
    
    @IBAction func back(_ sender: UIButton) {
        back()
    }
    
    @IBAction func addToReviewList(_ sender: BasicButton) {
        selectNewProgressionLevel(newProgressionLevel: UserProgression.level1)
    }
    
    @IBAction func selectProgressionLevel1(_ sender: Any) {
        selectNewProgressionLevel(newProgressionLevel: UserProgression.level1)
    }
    
    @IBAction func selectProgressionLevel2(_ sender: Any) {
        selectNewProgressionLevel(newProgressionLevel: UserProgression.level2)
    }
    
    @IBAction func selectProgressionLevel3(_ sender: Any) {
        selectNewProgressionLevel(newProgressionLevel: UserProgression.level3)
    }
    
    @IBAction func selectProgressionLevel4(_ sender: Any) {
        selectNewProgressionLevel(newProgressionLevel: UserProgression.level4)
    }
    
    @IBAction func selectProgressionLevel5(_ sender: Any) {
        selectNewProgressionLevel(newProgressionLevel: UserProgression.level5)
    }
    
    @IBAction func selectProgressionLevel6(_ sender: Any) {
        selectNewProgressionLevel(newProgressionLevel: UserProgression.level6)
    }
    
    @IBAction func selectProgressionLevel7(_ sender: Any) {
        selectNewProgressionLevel(newProgressionLevel: UserProgression.level7)
    }
    
    @IBAction func selectProgressionLevel8(_ sender: Any) {
        selectNewProgressionLevel(newProgressionLevel: UserProgression.level8)
    }
    
    private func selectNewProgressionLevel(newProgressionLevel: UserProgression){
        let (newProgression, dateToReview) =
            newProgressionLevel.stagnation(reviewedDate: Date())!
        
        do{
            
            let userLearningVerb = UserLearningVerb(id: userLearningVerb.id,
                                                    verb: userLearningVerb.verb,
                                                    dateToReview: dateToReview,
                                                    userProgression: newProgression)
            let result = try DbUserLearningVerbDAOImpl.shared.update(learningVerb: userLearningVerb.toDbUserLearningVerb())
            
            if (result > 0)  {
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
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
    
    // ----------------------
    // MARK: - View overrides
    // ----------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayCorrectVerbView()
    }
    
    override func viewDidLayoutSubviews() {
        setUp()
    }
    
    
    
    // ------------------
    // MARK: - Navigation
    // ------------------
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardVerbInReviewSegue"{
            let cardVCVerbInReview = segue.destination as! BackwardCardVC
            cardVCVerbInReview.verb = userLearningVerb.verb
        }
        else if segue.identifier == "cardVerbNotInReviewSegue"{
            let cardVCVerbNotInReview = segue.destination as! BackwardCardVC
            cardVCVerbNotInReview.verb = userLearningVerb.verb
        }
    }
    
    
    private func back(){
        dismiss(animated: true, completion: nil)
    }
    
    private func setUp(){
        self.progressionLevel1.setUp(userProgression: UserProgression.level1)
        self.progressionLevel2.setUp(userProgression: UserProgression.level2)
        self.progressionLevel3.setUp(userProgression: UserProgression.level3)
        self.progressionLevel4.setUp(userProgression: UserProgression.level4)
        self.progressionLevel5.setUp(userProgression: UserProgression.level5)
        self.progressionLevel6.setUp(userProgression: UserProgression.level6)
        self.progressionLevel7.setUp(userProgression: UserProgression.level7)
        self.progressionLevel8.setUp(userProgression: UserProgression.level8)
        
        
        switch userLearningVerb.userProgression {
        case UserProgression.level1:
            self.progressionLevel1.isSelected = true
            self.progressionLevel1.isEnabled = true
        case UserProgression.level2:
            self.progressionLevel2.isSelected = true
            self.progressionLevel2.isEnabled = true
        case UserProgression.level3:
            self.progressionLevel3.isSelected = true
            self.progressionLevel3.isEnabled = true
        case UserProgression.level4:
            self.progressionLevel4.isSelected = true
            self.progressionLevel4.isEnabled = true
        case UserProgression.level5:
            self.progressionLevel5.isSelected = true
            self.progressionLevel5.isEnabled = true
        case UserProgression.level6:
            self.progressionLevel6.isSelected = true
            self.progressionLevel6.isEnabled = true
        case UserProgression.level7:
            self.progressionLevel7.isSelected = true
            self.progressionLevel7.isEnabled = true
        case UserProgression.level8:
            self.progressionLevel8.isSelected = true
            self.progressionLevel8.isEnabled = true
        default:
            ()
        }
    }
    
    
    private func displayCorrectVerbView(){
        if(self.userLearningVerb.isInReviewList()){
            self.verbNotInReviewCardView.isHidden = true
            self.verbNotInReviewButtonView.isHidden = true
            self.verbInReviewScrollView.isHidden = false
        } else {
            self.verbNotInReviewCardView.isHidden = false
            self.verbNotInReviewButtonView.isHidden = false
            self.verbInReviewScrollView.isHidden = true
        }
    }
}
