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
    
    var nbrRandomVerb: Int!
    var nbrNotSeenVerb: Int!
    
    
    // ------------------
    // MARK: - Outlets
    // ------------------
    
    @IBOutlet weak var topPopUpConstraint: NSLayoutConstraint!

    @IBOutlet weak var leftPopUpConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addManuallyButton: UIButton!
    
    @IBOutlet weak var A2Button: LevelCheckBox!
    @IBOutlet weak var B1Button: LevelCheckBox!
    @IBOutlet weak var B2Button: LevelCheckBox!
    @IBOutlet weak var C1Button: LevelCheckBox!
    
    @IBOutlet weak var addRandomlyButton: BasicButton!
    

    @IBOutlet weak var lessRandomVerbButton: UIButton!
    @IBOutlet weak var moreRandomVerbButton: UIButton!
    @IBOutlet weak var nbrRandomVerbLabel: UILabel!
    
    
    // ------------------
    // MARK: - Actions
    // ------------------
    
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
        let selectedLevels = self.selectedLevels()
        if selectedLevels.isEmpty{
            showPopUp()
        } else {
            addVerb()
        }
        
//        let selectedLevels = self.selectedLevels()
//        if selectedLevels.isEmpty{
//            showPopUp()
//        } else if self.wholeAppProduct == nil && BoughtIAPProducts.shared.isBought(productIdentifier: IAProducts.wholeApp){
//            addVerb()
//        } else if self.wholeAppProduct == nil && !NetworkActivityIndicatorManagment.isInternetAvailable() {
//            // Internet is not available
//            // TODO
//            let alert = UIAlertController(title: "Pas de connection internet",
//                                          message: "Cette partie de l'application requiert une connection à l'AppStore", preferredStyle: .alert)
//
//            let clearAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//            alert.addAction(clearAction)
//            present(alert, animated: true, completion: nil)
//
//        } else if self.wholeAppProduct == nil{
//            // It has to wait for the product
//        } else if self.wholeAppProduct != nil && IAProducts.store.isProductPurchased(self.wholeAppProduct!.productIdentifier) {
//            addVerb()
//        } else if IAPHelper.canMakePayments() {
//            performSegue(withIdentifier: "IAPurchasesSegue", sender: nil)
//        } else {
//            // can NOT make payement
//            // TODO
//            let alert = UIAlertController(title: "Permission refusée", message: "Si vous voyez cette page, s'il vous plaît contactez nous. L'AppStore devrait authorisé toute personne de 4 ans et plus", preferredStyle: .alert)
//
//            let clearAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//            alert.addAction(clearAction)
//            present(alert, animated: true, completion:nil)
//        }
    }
    
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
        self.addRandomlyButton.layout()
    }
    
    override func systemLayoutFittingSizeDidChange(forChildContentContainer container: UIContentContainer) {
        self.C1Button.setup()
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
