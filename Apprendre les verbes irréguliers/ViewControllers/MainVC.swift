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
    

    
    
    
    
    /// Take care of the set-up in any cases
    fileprivate func setUp(){
         FirstLaunch().execute(onFistLaunch: setUpFirstLaunch, whenWasLaunchedBefore: setUpWasLaunchedBefore)
    }
    
    /// Take care of the set up on the first launch
    fileprivate func setUpFirstLaunch(){
        self.nbrVerbToReviewTodayLabel.text = String(0)
        self.nbrVerbInReviewListLabel.text = "Il y a " + String(0) + " à revoir" //TODO
        
        DbVerbDAOImpl.shared.createTable()
        DbVerbTranslationDAOImpl.shared.createTable()
        VerbDAOImpl.shared.insert(verbs: Verbs.verbs)
    }

    /// Take care of the set up when the app was already launched before
    fileprivate func setUpWasLaunchedBefore(){
        self.nbrVerbToReviewTodayLabel.text = String(30)
        self.nbrVerbInReviewListLabel.text = "Il y a " + String(44) + " à revoir" //TODO
        
        
        
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
