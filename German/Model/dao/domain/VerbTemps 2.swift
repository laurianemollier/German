//
//  VerbForm.swift
//  German
//
//  Created by Lauriane Mollier on 10/2/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct VerbTemps: Hashable {
    
    private let changingVowelRange: NSRange
    
    let id: String
    
    let value: String
    
    /// - Returns: The splited verb form, without pronoun.
    ///            The second string the changing vowel.
    ///            Example:
    ///               Full verb form: "nimmt … ab"
    ///               Returns : ("n", "i", "mmt … ab"")
    let splitedWithoutPronoun: (String, String, String)
    
    /// - Returns: The splited verb form, with the pronoun.
    ///            The second string the changing vowel.
    ///            Example:
    ///               Full verb form: "nimmt … ab"
    ///               Returns : ("er n", "i", "mmt … ab"")
    private let splitedWithPronoun: (String, String, String)
    
    
    init(value: String, changingVowelRange: NSRange) {
        self.value = value
        self.changingVowelRange = changingVowelRange
        
        let startIndex: String.Index = value.index(value.startIndex, offsetBy: changingVowelRange.location)
        let endIndex = value.index(startIndex, offsetBy: changingVowelRange.length)
        
        self.splitedWithoutPronoun = (
            String(value[..<startIndex]),
            String(value[startIndex..<endIndex]),
            String(value[endIndex...])
        )
        self.splitedWithPronoun = (
            "er " + String(value[..<startIndex]),
            String(value[startIndex..<endIndex]),
            String(value[endIndex...])
        )
    }
    
    static func == (lhs: VerbTemps, rhs: VerbTemps) -> Bool {
        lhs.value == rhs.value
    }
}

