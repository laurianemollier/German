//
//  AddVerbsCV.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/07/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit
import StoreKit

class AddVerbsCV: UIViewController {
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    var products: [SKProduct]?
    var wholeAppProduct: SKProduct?
    
    let step: Int = 1
    
    // ------------------
    // MARK: - Outlets
    // ------------------
    
    @IBOutlet weak var topPopUpConstraint: NSLayoutConstraint!

    @IBOutlet weak var leftPopUpConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var A2Button: LevelCheckBox!
    @IBOutlet weak var B1Button: LevelCheckBox!
    @IBOutlet weak var B2Button: LevelCheckBox!
    @IBOutlet weak var C1Button: LevelCheckBox!
    
    
    // ------------------
    // MARK: - Actions
    // ------------------
    

    @IBAction func closePopUp(_ sender: UIButton) {
        closePopUp()
    }

    
    // ----------------------
    // MARK: - View overrides
    // ----------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        closePopUp()
    }
    
    override func viewDidLayoutSubviews() {
        self.A2Button.setup()
        self.B1Button.setup()
        self.B2Button.setup()
        self.C1Button.setup()
    }
    
    override func systemLayoutFittingSizeDidChange(forChildContentContainer container: UIContentContainer) {
        self.C1Button.setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // ------------------
    // MARK: - Navigation
    // ------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "IAPurchasesSegue" {
            let vc = segue.destination as! IAPurchaseVC
            vc.wholeAppProduct = self.wholeAppProduct!
            vc.products = self.products
        }

    }
    
    // ------------------
    // MARK: - Private
    // ------------------
    
    private func selectedLevels() -> [Level] {
        var selectedLevels = [Level]()
        
        if self.A2Button.isSelected{
            selectedLevels.append(Level.A2)
        }
        if self.B1Button.isSelected{
            selectedLevels.append(Level.B1)
        }
        if self.B2Button.isSelected{
            selectedLevels.append(Level.B2)
        }
        if self.C1Button.isSelected{
            selectedLevels.append(Level.C1)
        }
        return selectedLevels
    }
    
    private func addVerb(){
//        let selectedLevels = self.selectedLevels()
//        if selectedLevels.isEmpty{
//            performSegue(withIdentifier: "SelectLevelSeque", sender: nil)
//        }else{
//            do{
//                try DAO.shared.addRandomVerbToReviewList(ofLevel: selectedLevels, count: self.nbrRandomVerb)
//                _ = self.navigationController?.navigationController?.popViewController(animated: true)
//                
//                navigationController?.popViewController(animated: true)
//                dismiss(animated: true, completion: nil)
//            }
//            catch{
//                // TODO
//                SpeedLog.print(error)
//            }
//        }
    }
    
    // https://medium.com/@mohammadhemani/set-the-next-view-controller-to-show-as-full-screen-in-ios-13-e7e42e20587a
    private func back(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    private func loadProduct(){
        IAProducts.store.requestProducts{success, products in
            if success {
                self.products = products!
                self.wholeAppProduct = products!.first
            }
        }
    }
    
    private func closePopUp(){
        self.leftPopUpConstraint.constant = self.view.frame.width
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func showPopUp(){
        self.leftPopUpConstraint.constant = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }


 
}
