//
//  StatisticsVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 21/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class StatisticsVC: UIViewController {

    @IBOutlet weak var progressionNotSeenYet: StatisticsButton!
    
    @IBOutlet weak var progressionLevel1: StatisticsButton!
    
    @IBOutlet weak var progressionLevel2: StatisticsButton!
    
    @IBOutlet weak var progressionLevel3: StatisticsButton!
    
    @IBOutlet weak var progressionLevel4: StatisticsButton!
    
    @IBOutlet weak var progressionLevel5: StatisticsButton!
    
    @IBOutlet weak var progressionLevel6: StatisticsButton!
    
    @IBOutlet weak var progressionLevel7: StatisticsButton!
    
    @IBOutlet weak var progressionLevel8: StatisticsButton!
    
    
    @IBOutlet weak var progressionToIgnore: StatisticsButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.progressionNotSeenYet.setUp(userProgression: UserProgression.notSeenYet, nbrVerb: 22)
        self.progressionLevel1.setUp(userProgression: UserProgression.level1, nbrVerb: 22)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
