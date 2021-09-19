//
//  IAPProducts.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 03/09/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//


import Foundation

public struct IAProducts {
    
    public static let wholeApp = "org.lauriane.mollier.irregular.verbs.german.wholeApp"
    
    private static let productIdentifiers: Set<ProductIdentifier> = [IAProducts.wholeApp]
    
    public static let store = IAPHelper(productIds: IAProducts.productIdentifiers)
    
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    return productIdentifier.components(separatedBy: ".").last
}
