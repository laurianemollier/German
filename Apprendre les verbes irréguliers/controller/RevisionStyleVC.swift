//
//  RevisionStyleVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 8/30/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import UIKit

class RevisionStyleVC: UIViewController {

    /// Determine number of verb that the user will review in one review session
    var nbrVerbInReviewSession = 10 // TODO: make a variable
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // ------------------
    // MARK: - Navigation
    // ------------------
    
    @IBAction func back(_ sender: UIButton) {
        back()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewVerbs"{
            prepareReviewVerbsVC(segue)
        }
    }
    
    private func prepareReviewVerbsVC(_ segue: UIStoryboardSegue){
        let cv = segue.destination as! ReviewVerbsVC
        
        do {
            let verbsRangeToReviewToday = try DAO.shared.verbToReviewToday(limit: nbrVerbInReviewSession)
            cv.verbsToReview = verbsRangeToReviewToday
        }
        catch{
            cv.verbsToReview = []
        }
    }
    
    // https://medium.com/@mohammadhemani/set-the-next-view-controller-to-show-as-full-screen-in-ios-13-e7e42e20587a
    private func back(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

}
