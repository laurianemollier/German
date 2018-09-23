//
//  SelectLevelVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 09/09/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class SelectLevelVC: UIViewController {

    @IBAction func centralButton(_ sender: UIButton) {
        closePopUp()
    }
    @IBAction func upButton(_ sender: UIButton) {
        closePopUp()
    }
    @IBAction func buttomButton(_ sender: UIButton) {
        closePopUp()
    }
    @IBAction func leftButton(_ sender: UIButton) {
        closePopUp()
    }
    @IBAction func rightButton(_ sender: UIButton) {
        closePopUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func closePopUp(){
        dismiss(animated: true, completion: nil)
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
