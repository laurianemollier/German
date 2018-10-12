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
    var forwardCardVC: ForwarCardVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardSegue"{
            print("---- cardSegue ----")
            self.forwardCardVC = segue.destination as? ForwarCardVC
            print("88888")
            self.forwardCardVC.verb = userLearningVerb.verb
            print("111111")
        }
    }

}
