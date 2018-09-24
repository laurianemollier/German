//
//  StatisticsVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 21/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class StatisticsVC: UIViewController {
    
    var allLearningVerbs: [UserLearningVerb]!
    
    
    @IBAction func back(_ sender: UIButton) {
        back()
    }
    
    @IBOutlet weak var progressionNotSeenYet: StatisticsButton!
    
    @IBOutlet weak var progressionLevel1: StatisticsButton!
    
    @IBOutlet weak var progressionLevel2: StatisticsButton!
    
    @IBOutlet weak var progressionLevel3: StatisticsButton!
    
    @IBOutlet weak var progressionLevel4: StatisticsButton!
    
    @IBOutlet weak var progressionLevel5: StatisticsButton!
    
    @IBOutlet weak var progressionLevel6: StatisticsButton!
    
    @IBOutlet weak var progressionLevel7: StatisticsButton!
    
    @IBOutlet weak var progressionLevel8: StatisticsButton!
    
//    @IBOutlet weak var progressionToIgnore: StatisticsButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do{
            self.allLearningVerbs =  try DbUserLearningVerbDAOImpl.shared.all()
        }
        catch{
            SpeedLog.print(error)
            // TODO
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUp(){
        self.progressionNotSeenYet.setUp(userProgression: UserProgression.notSeenYet,
                                         nbrVerb: nbrVerbFor(progression: UserProgression.notSeenYet))
        self.progressionLevel1.setUp(userProgression: UserProgression.level1,
                                     nbrVerb: nbrVerbFor(progression: UserProgression.level1))
        self.progressionLevel2.setUp(userProgression: UserProgression.level2,
                                     nbrVerb: nbrVerbFor(progression: UserProgression.level2))
        self.progressionLevel3.setUp(userProgression: UserProgression.level3,
                                     nbrVerb: nbrVerbFor(progression: UserProgression.level3))
        self.progressionLevel4.setUp(userProgression: UserProgression.level4,
                                     nbrVerb: nbrVerbFor(progression: UserProgression.level4))
        self.progressionLevel5.setUp(userProgression: UserProgression.level5,
                                     nbrVerb: nbrVerbFor(progression: UserProgression.level5))
        self.progressionLevel6.setUp(userProgression: UserProgression.level6,
                                     nbrVerb: nbrVerbFor(progression: UserProgression.level6))
        self.progressionLevel7.setUp(userProgression: UserProgression.level7,
                                     nbrVerb: nbrVerbFor(progression: UserProgression.level7))
        self.progressionLevel8.setUp(userProgression: UserProgression.level8,
                                     nbrVerb: nbrVerbFor(progression: UserProgression.level8))
//        self.progressionToIgnore.setUp(userProgression: UserProgression.toIgnore,
//                                     nbrVerb: nbrVerbFor(progression: UserProgression.toIgnore))
    }
    
    
    private func nbrVerbFor(progression: UserProgression) -> Int{
        return self.allLearningVerbs.filter({$0.userProgression == progression}).count
    }

    
    
    
    private func back(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
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
