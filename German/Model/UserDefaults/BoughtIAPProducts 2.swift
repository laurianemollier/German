//
//  BoughtIAPProducts.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 13/09/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation


final class BoughtIAPProducts{
    
    private let key = "org.lauriane-mollier.irregular-verbs.german"
    
    static let shared = BoughtIAPProducts()
    
    private init(){}
    
    func isBought(productIdentifier: String) -> Bool{
        if let result = UserDefaults.standard.object(forKey: key + productIdentifier) as? Bool {
            return result
        }else{
            return false
        }
    }
    func bought(productIdentifier: String){
        UserDefaults.standard.setValue(true, forKey: key + productIdentifier)
        UserDefaults.standard.synchronize()
    }
    
}
