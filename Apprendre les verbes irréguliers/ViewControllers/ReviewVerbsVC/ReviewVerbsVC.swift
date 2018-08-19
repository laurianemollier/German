//
//  ReviewVerbsVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/07/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class ReviewVerbsVC: UIViewController {

    
    var isCardForward: Bool!
    
    @IBOutlet weak var forwarCard: UIView!
    
    @IBOutlet weak var backwardCard: UIView!
    
    @IBOutlet weak var buttonOnCard: UIButton!
    
    
    @IBAction func turnCardClickOnCard(_ sender: UIButton) {
        turnCard(sender)
    }
    
    

    private func turnCard(_ sender: UIButton){
        if self.isCardForward{
            flipCard(visible: self.forwarCard, notVisibleYet: self.backwardCard)
        }
        else{
            flipCard(visible: self.backwardCard, notVisibleYet: self.forwarCard)
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
        self.isCardForward = true
        self.forwarCard.isHidden = false
        self.backwardCard.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forwardCardSegue"{
            let vc = segue.destination as! ForwarCardVC
            vc.translation = "coucou"
            
        }
        else if segue.identifier == "backCardSegue"{
            let vc = segue.destination as! BackwardCardVC
            vc.translation = "coucoc"
            vc.infinitive = "bonjour"

        }

    }
 

}
