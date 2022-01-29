//
//  Text+Ext.swift
//  German
//
//  Created by Lauriane Mollier on 10/2/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

extension Text {
    func verbChangingVowel() -> Text {
        self.foregroundColor(Color.brandPrimary)
            .fontWeight(.bold)
    }
    
    static func verbTemps(_ verbTemps: VerbTense) -> Text {
        Text(verbTemps.splitedWithoutPronoun.0) +
            Text(verbTemps.splitedWithoutPronoun.1)
            .verbChangingVowel() +
            Text(verbTemps.splitedWithoutPronoun.2)
    }
    
}
