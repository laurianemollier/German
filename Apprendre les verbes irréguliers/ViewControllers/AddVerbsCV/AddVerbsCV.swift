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
    
    var products: [SKProduct]?
    var wholeAppProduct: SKProduct?
    
    let step: Int = 1
    
    var nbrRandomVerb: Int!
    var nbrNotSeenVerb: Int!
    
    
    @IBOutlet weak var addManuallyButton: UIButton!
    
    @IBOutlet weak var A2Button: LevelCheckBox!
    @IBOutlet weak var B1Button: LevelCheckBox!
    @IBOutlet weak var B2Button: LevelCheckBox!
    @IBOutlet weak var C1Button: LevelCheckBox!
    
    
    
    
    @IBOutlet weak var lessRandomVerbButton: UIButton!
    @IBOutlet weak var moreRandomVerbButton: UIButton!
    @IBOutlet weak var nbrRandomVerbLabel: UILabel!
    
    
    @IBAction func back(_ sender: UIButton) {
        back()
    }
    
    @IBAction func lessRandomVerb(_ sender: UIButton) {
        self.nbrRandomVerb = [self.nbrRandomVerb - self.step, 0].max()
        self.nbrRandomVerbLabel.text = String(self.nbrRandomVerb)
    }
    
    @IBAction func moreRandomVerb(_ sender: UIButton) {
        self.nbrRandomVerb = [self.nbrRandomVerb + self.step, self.nbrNotSeenVerb].min()!
        self.nbrRandomVerbLabel.text = String(self.nbrRandomVerb)
    }
    
    
    
    @IBAction func addRamdomly(_ sender: BasicButton) {
        if self.wholeAppProduct == nil{
            // Make a future
            SpeedLog.print("TODO: Make a future")
        } else if IAProducts.store.isProductPurchased(self.wholeAppProduct!.productIdentifier) {
            addVerb()
        } else if IAPHelper.canMakePayments() {
            performSegue(withIdentifier: "IAPurchasesSegue", sender: nil)
        } else { // can NOT make payement
            // TODO: can not make payement
            SpeedLog.print("TODO: can not make payement")
        }
    }
    
    private func addVerb(){
        let selectedLevels = self.selectedLevels()
        if selectedLevels.isEmpty{
            performSegue(withIdentifier: "SelectLevelSeque", sender: nil)
        }else{
            do{
                try DbUserLearningVerbDAOImpl.shared.addRandomVerbToReviewList(ofLevel: selectedLevels, nbr: self.nbrRandomVerb)
                _ = self.navigationController?.navigationController?.popViewController(animated: true)
                
                navigationController?.popViewController(animated: true)
                dismiss(animated: true, completion: nil)
            }
            catch{
                // TODO
                SpeedLog.print(error)
            }
        }
    }
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadProduct() // purchases
        
        // TODO: When there is no verb to add
        do {
            self.nbrNotSeenVerb = try DbUserLearningVerbDAOImpl.shared.nbrVerNotbInReviewList()
            self.nbrRandomVerb = [10, nbrNotSeenVerb].min()
            self.nbrRandomVerbLabel.text = String(self.nbrRandomVerb)
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
        if segue.identifier == "IAPurchasesSegue" {
            let vc = segue.destination as! IAPurchaseVC
            vc.wholeAppProduct = self.wholeAppProduct
            vc.products = self.products
        }

    }
    
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

 
}
