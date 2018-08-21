//
//  AddVerbsCV.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/07/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class AddVerbsCV: UIViewController {



    let step: Int = 1
    
    var nbrRandomVerb: Int = 5
    var nbrNotSeenVerb: Int!
    
    
    @IBOutlet weak var addManuallyButton: UIButton!
    
    @IBOutlet weak var B1Button: LevelCheckBox!
    
    @IBAction func optionBoxA2(_ sender: UIButton) {
        optionBox(button: sender)
    }

    @IBAction func optionBoxB2(_ sender: UIButton) {
        optionBox(button: sender)
    }
    @IBAction func optionBoxC1(_ sender: UIButton) {
        optionBox(button: sender)
    }
    
    func optionBox(button: UIButton){

    }
    
    
    
    @IBOutlet weak var lessRandomVerbButton: UIButton!
    @IBOutlet weak var moreRandomVerbButton: UIButton!
    @IBOutlet weak var nbrRandomVerbLabel: UILabel!
    
    
    
    @IBAction func lessRandomVerb(_ sender: UIButton) {
        self.nbrRandomVerb = [self.nbrRandomVerb - self.step, 0].max()!
        self.nbrRandomVerbLabel.text = String(self.nbrRandomVerb)
    }
    
    @IBAction func moreRandomVerb(_ sender: UIButton) {
        self.nbrRandomVerb = [self.nbrRandomVerb + self.step, self.nbrNotSeenVerb].min()!
        self.nbrRandomVerbLabel.text = String(self.nbrRandomVerb)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nbrRandomVerbLabel.text = String(self.nbrRandomVerb)
        // TODO: When there is no verb to add
        do {
            self.nbrNotSeenVerb = try DbUserLearningVerbDAOImpl.shared.nbrNotVerbInReviewList()
        }
        catch{
            // TODO
            SpeedLog.print(error)
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listVerbsSegue" {
            let vc = segue.destination as? ListVerbsVC
            do {
                try vc?.learningVerbs = DbUserLearningVerbDAOImpl.shared.all()
            }
            catch{
                // TODO
                SpeedLog.print(error)
            }
            
        }
    }


}
