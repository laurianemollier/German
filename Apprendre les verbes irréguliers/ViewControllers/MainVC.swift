//
//  MainVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/07/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    var nbrVerbInReviewList: Int!
    var nbrVerbToReviewToday: Int!
    
    var nbrVerbInReviewSession = 10
    
    @IBOutlet weak var nbrVerbToReviewTodayButton: UIButton!
    
    @IBOutlet var reviewVerbs: BasicButton!
    @IBOutlet weak var nbrVerbInReviewListLabel: UILabel!
    
    
    @IBOutlet weak var addVerbsButton: BasicButton!
    @IBOutlet weak var seeAllVerbsButton: BasicButton!
    @IBOutlet weak var yourStatisticsButton: BasicButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    // MARK: - SetUp
    
    // TODO when they is an error
    private func setUp(){
        if FirstLaunch().isFirstLaunch {
            firstLaunchSetUp()
        }
        if Database.shared.successfulConnection{
            do{
                self.nbrVerbInReviewList = try DbUserLearningVerbDAOImpl.shared.nbrVerbInReviewList()
                self.nbrVerbToReviewToday = try DbUserLearningVerbDAOImpl.shared.nbrVerbToReviewToday()
            }
            catch{
                SpeedLog.print(error)
                // TODO: To show the user that they is an error
            }
            textAndDesignSetUp()
            
        }
    }
    
    private func firstLaunchSetUp(){
        do{
            try SetUpDatabase.setUp()
        }
        catch{
            SpeedLog.print(error)
            // TODO: To show the user that they is an error
        }
    }
    
    private func textAndDesignSetUp(){
        self.nbrVerbToReviewTodayButton.setTitle(String(self.nbrVerbToReviewToday), for: .normal)
        self.nbrVerbInReviewListLabel.text = "Il y a " + String(self.nbrVerbInReviewList) + " à revoir" //TODO
        
        if self.nbrVerbToReviewToday == 0{
            self.nbrVerbToReviewTodayButton.isEnabled = false
            self.reviewVerbs.isEnabled = false
        }
        else{
            self.nbrVerbToReviewTodayButton.isEnabled = true
            self.reviewVerbs.isEnabled = true
        }
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "reviewVerbs" && self.nbrVerbInReviewList == 0 {
            
        }
        else if segue.identifier == "reviewVerbs"{

            let cv = segue.destination as! ReviewVerbsVC
            
            do {
                // TODO: to do it before
                let verbsRangeToReviewToday = try DbUserLearningVerbDAOImpl.shared.verbsToReviewToday(limit: nbrVerbInReviewSession)
                cv.verbsToReview = verbsRangeToReviewToday
            }
            catch{
                cv.verbsToReview = []
            }
        
        }
    }
    
    



}
