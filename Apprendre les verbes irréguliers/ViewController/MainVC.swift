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
        
        self.nbrVerbToReviewTodayLabel.text = String(1) // TODO
        self.nbrVerbInReviewListLabel.text = "Il y a " + String(30) + " à revoir" //TODO
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
