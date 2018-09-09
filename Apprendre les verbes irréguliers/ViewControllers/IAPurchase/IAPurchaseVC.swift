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
    
    var products: [SKProduct]?
    
    
    let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.formatterBehavior = .behavior10_4
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    

    var wholeAppProduct: SKProduct? {
        didSet {
            guard let wholeAppProduct = wholeAppProduct else { return }

            if IAProducts.store.isProductPurchased(wholeAppProduct.productIdentifier) {
                self.buyWholeAppButton.setTitle("is purchased", for: .normal)
            } else if IAPHelper.canMakePayments() {
                self.priceFormatter.locale = wholeAppProduct.priceLocale
                let price = self.priceFormatter.string(from: wholeAppProduct.price)

               self.buyWholeAppButton.setTitle(price, for: .normal)
            } else {
                self.buyWholeAppButton.setTitle("Not aivalable", for: .normal)
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadProduct()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    private func loadProduct(){
        IAProducts.store.requestProducts{success, products in
            if success {
                self.products = products!
                self.wholeAppProduct = products!.first
            }
        }
    }
    
    
    
    
    
    
    
    
    @IBOutlet var buyWholeAppButton: UIButton!
    
    @IBAction func buyWholeApp(_ sender: UIButton) {
        IAProducts.store.buyProduct(self.wholeAppProduct!)
    }
    
    
    @IBAction func restore(_ sender: UIButton) {
        IAProducts.store.restorePurchases()
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
