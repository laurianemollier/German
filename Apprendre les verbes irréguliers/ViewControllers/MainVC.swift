//
//  MainVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/07/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var nbrVerbToReviewTodayLabel: UILabel!
    
    @IBOutlet weak var nbrVerbInReviewListLabel: UILabel!
    
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
            labelSetUp()
            
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
    
    private func labelSetUp(){
        do{
            let nbrVerbInReviewList = try DbUserLearningVerbDAOImpl.shared.nbrVerbInReviewList()
            let nbrVerbToReviewToday = try DbUserLearningVerbDAOImpl.shared.nbrVerbToReviewToday()
            
            self.nbrVerbToReviewTodayLabel.text = String(nbrVerbToReviewToday)
            self.nbrVerbInReviewListLabel.text = "Il y a " + String(nbrVerbInReviewList) + " à revoir" //TODO
        }
        catch{
            SpeedLog.print(error)
            // TODO: To show the user that they is an error
        }
    
    }

    

    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "reviewVerbs"{
            let cv = segue.destination as! ReviewVerbsVC
        }
    }
    
    



}
