//
//  IAPurchaseVC.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 07/09/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit
import StoreKit

class IAPurchaseVC: UIViewController {
    
    var products: [SKProduct]!
    var wholeAppProduct: SKProduct!
    
    let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        
        return formatter
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.priceFormatter.locale = self.wholeAppProduct.priceLocale
        let price = self.priceFormatter.string(from: self.wholeAppProduct.price)
        self.buyWholeAppButton.setUp(price: price!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(IAPurchaseVC.handlePurchaseNotification(_:)),
                                               name: .IAPHelperPurchaseNotification,
                                               object: nil)
        
    }
    
    @objc func handlePurchaseNotification(_ notification: Notification) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    
    
    
    
    
    
    
    
    @IBOutlet var buyWholeAppButton: PurchaseUIButton!
    
    @IBAction func buyWholeApp(_ sender: PurchaseUIButton) {
        IAProducts.store.buyProduct(self.wholeAppProduct!)
    }
    
    
    @IBAction func restore(_ sender: UIButton) {
        IAProducts.store.restorePurchases()
    }
    
    
    @IBAction func close(_ sender: UIButton) {
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
