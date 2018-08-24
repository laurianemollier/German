//
//  BackwardCardVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 19/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class BackwardCardVC: UIViewController {

    var verb: Verb!
    
    @IBOutlet var backwardView: VerbCardView!
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    func reset(verb: Verb){
        self.verb = verb
        self.backwardView.setup(verb: verb, backward: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
