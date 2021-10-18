//
//  Verb.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 09/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

/// A verb to learn
struct Verb{
    
    /// The id for the verb
    let id: Int64
    
    /// The level at which you are supposed to learn this verb.
    let level: Level
    
    /// The form to which the verb belongs.
    let form: Form
    
    /// The differents temps of this verb
    /// (infinitive, present, simple past, past participle)
    let temps: (infinitive: VerbTemps, present: VerbTemps, simplePast: VerbTemps, pastParticiple: VerbTemps)
    
    /// The translation avalable in each language
    private var translations = [Lang:String]()

    /* Constructor */
    
    /// Create a verb to learn
    ///
    /// - Parameters:
    ///     - level: The level at which you are supposed to learn this verb.
    ///     - form: The form to which the verb belongs.
    ///     - verb: The differents temps of this verb (infinitive, present, simple past, past participle)
    ///     - changingVowel: The range where is located the changing vowel (infinitive, present, simple past, past participle)
    ///     - translations: The translation avalable in each language
    ///
    /// - Returns: A verb
    init(id: Int64, level: Level, form: Form,
         verb: (String, String, String, String),
         changingVowel: (NSRange, NSRange, NSRange, NSRange),
         translations: [(Lang, String)]){
        self.id = id + 1
        self.level = level
        self.form = form
        self.temps = (
            infinitive: VerbTemps(value: verb.0, changingVowelRange: changingVowel.0),
            present: VerbTemps(value: verb.1, changingVowelRange: changingVowel.1),
            simplePast: VerbTemps(value: verb.2, changingVowelRange: changingVowel.2),
            pastParticiple: VerbTemps(value: verb.3, changingVowelRange: changingVowel.3)
            )
        translations.forEach({
            self.translations[$0] = $1
        })
    }
    
    /* Getter fonctions */
    
    /// Get the translation of this verb in the given language
    /// - Parameters:
    ///     - lang: The language in which the translation is done
    func translation(_ lang: Lang) -> String {
        return translations[lang]!
    }

}
