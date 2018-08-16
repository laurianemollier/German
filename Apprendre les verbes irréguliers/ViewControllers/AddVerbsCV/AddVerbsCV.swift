//
//  AddVerbsCV.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/07/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class AddVerbsCV: UIViewController {

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
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        B1Button.setTitle("coucouc", for: .selected)
        print(B1Button.title(for: .selected))

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
