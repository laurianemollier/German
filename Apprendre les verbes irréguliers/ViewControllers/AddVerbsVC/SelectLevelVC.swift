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
    
    private func closePopUp(){
        dismiss(animated: true, completion: nil)
    }



}
