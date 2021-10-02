//
//  VerbForm.swift
//  German
//
//  Created by Lauriane Mollier on 10/2/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct VerbTemps {
    
    private let form: String
    
    private let changingVowelRange: NSRange
    
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
    
    
    init(form: String, changingVowelRange: NSRange) {
        self.form = form
        self.changingVowelRange = changingVowelRange
        
        let startIndex: String.Index = form.index(form.startIndex, offsetBy: changingVowelRange.location)
        let endIndex = form.index(startIndex, offsetBy: changingVowelRange.length)
        
        self.splitedWithoutPronoun = (
            String(form[..<startIndex]),
            String(form[startIndex..<endIndex]),
            String(form[endIndex...])
        )
        self.splitedWithPronoun = (
            "er " + String(form[..<startIndex]),
            String(form[startIndex..<endIndex]),
            String(form[endIndex...])
        )
    }
}

