//
//  ReviewVerbsVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/07/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

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
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    
    @IBAction func revealClickButton(_ sender: UIButton) {
        revealCard(sender)
    }
    @IBAction func revealClickOnCard(_ sender: UIButton) {
        revealCard(sender)
    }
    
    @IBAction func yesAction(_ sender: UIButton) {
        
        let verbReviewed: UserLearningVerb = self.verbsToReview[self.index]
        let updatedVerbReviewed = UserLearningVerb(id: verbReviewed.id,
                                                   verb: verbReviewed.verb,
                                                   dateToReview: verbReviewed.dateToReview!.tomorrow,
                                                   userProgression: UserProgression.level2)
        nextVerb(updatedVerbReviewed: updatedVerbReviewed)
    }
    
    @IBAction func noAction(_ sender: UIButton) {
        nextVerb(updatedVerbReviewed: nil)
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

        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // TODO:
        let cross = UIImage(named: "test")
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: cross, style: .plain, target: self, action: #selector(cancelTapped))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))


//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(cancelTapped))
        
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
        }
        else{
            flipCard(visible: self.backwardCard, notVisibleYet: self.forwarCard)
        }
        self.isCardForward = false
        
        self.realButtonOutsideCard.isHidden = true
        self.yesButton.isHidden = false
        self.noButton.isHidden = false
    }
    
    
    private func resetCard(verb: Verb){
        self.isCardForward = true
        self.forwarCard.isHidden = false
        self.backwardCard.isHidden = true
        
        self.realButtonOutsideCard.isHidden = false
        self.yesButton.isHidden = true
        self.noButton.isHidden = true
        
        self.forwardCardVC.reset(verb: verb)
        
        // Set the data in for the back of the car
        self.backwardCardVC.reset(verb: verb)
    }
    
    
    private func endRevisionSession(){
        let dbResultVerbsReviewed = resultVerbsReviewed.map({ $0.toDbUserLearningVerb()})
        do{
            let results: [Int] = try DbUserLearningVerbDAOImpl.shared.update(learningVerbs: dbResultVerbsReviewed)
            if results.forAll(where: {$0 > 0})  {
                // TODO: Show the success
                self.navigationController?.popViewController(animated: true)
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
    
 

}
