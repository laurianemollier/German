//
//  IAPProducts.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 03/09/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation


enum IAPProducts: String {
    case consumable = "com.kiloloco.GetPaper.KLConsumable"
    case nonConsumable = "com.kiloloco.GetPaper.KLNonConsumable"
    case autoRenewableSubscription = "com.kiloloco.GettinPaper.KLAutoRenewableSubscription"
    case nonRenewingSubscription = "com.kiloloco.GetPaper.KLNonRenewingSubscription"
    
    
    static let allProductIDs: Set = [IAPProducts.consumable.rawValue,
                                IAPProducts.nonConsumable.rawValue,
                                IAPProducts.autoRenewableSubscription.rawValue,
                                IAPProducts.nonRenewingSubscription.rawValue]

}
