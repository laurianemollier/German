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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayCorrectVerbView()
    }
    

    // MARK: - Navigation

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

    @IBAction func addToReviewList(_ sender: BasicButton) {

    }
    
    override func viewDidLayoutSubviews() {
        setUp()
    }
    
    @IBAction func back(_ sender: UIButton) {
        back()
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
