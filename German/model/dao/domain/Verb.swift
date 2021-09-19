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
class Verb{
    
    /// The id for the verb
    let id: Int64
    
    /// The level at which you are supposed to learn this verb.
    let level: Level
    
    /// The form to which the verb belongs.
    let form: Form
    
    /// The differents temps of this verb
    /// (infinitive, present, simple past, past participle)
    private let verb: (infinitive: String, present: String, simplePast: String, pastParticiple: String)
    
    private let changingVowel : (infinitive: NSRange, present: NSRange, simplePast: NSRange, pastParticiple: NSRange)
    
    /// The translation avalable in each language
    private var translations = [Lang:String]()
 
    /// If true, display the pronoun while conjugating the verb
    private var pronoun: Bool = false
    
    private let colorChangedVowel = UIColor.red
    

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
        self.verb = verb
        self.changingVowel = changingVowel
        
        translations.forEach({
            self.translations[$0] = $1
        })
    }
    
    init(dbVerb: DbVerb, dbVerbTranslations: [DbVerbTranslation]){
        /// TODO: verify if all is correct
        
        self.id = dbVerb.id!
        self.level = dbVerb.level
        self.form = dbVerb.form
        self.verb = (infinitive: dbVerb.infinitive,
                     present: dbVerb.present,
                     simplePast: dbVerb.simplePast,
                     pastParticiple: dbVerb.pastParticiple)
        // TODO make the true range
        self.changingVowel = (infinitive: NSRange(location:2, length:5),
                              present: NSRange(location:2, length:5),
                              simplePast: NSRange(location:2, length:5),
                              pastParticiple: NSRange(location:2, length:5))
        
        dbVerbTranslations.forEach({
            self.translations[$0.lang] = $0.translation
        })
        
    }
    
    
    
    /* Getter fonctions */
    
    /// Get the infinitive form of this verb
    func infinitive() -> String {return verb.0}
    
    /// Get the present form of this verb
    func present() -> String {return formatConjugatedForm(verb.1)}
    
    /// Get the simple past of this verb
    func simplePast() -> String {return formatConjugatedForm(verb.2)}
    
    /// Get the past participle of this verb
    func pastParticiple() -> String {return formatConjugatedForm(verb.3)}
    
    /// Get the translation of this verb in the given language
    /// - Parameters:
    ///     - lang: The language in which the translation is done
    func translation(_ lang: Lang) -> String {return translations[lang]!}
    
    
    func infinitiveColored(font: UIFont) -> NSMutableAttributedString {
        
        let attributes: [NSAttributedStringKey: Any] = [.font: font]
        let attributedString = NSMutableAttributedString(string: self.verb.infinitive, attributes: attributes)
        
        // here you change the character to the color that you want
        attributedString.addAttribute(.foregroundColor, value: self.colorChangedVowel, range: self.changingVowel.infinitive)

        return attributedString
    }
    
    func presentColored(font: UIFont) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self.verb.present,
                                                         attributes: [.font: font])
        
        // here you change the character to the color that you want
        attributedString.addAttribute(.foregroundColor, value: self.colorChangedVowel, range: self.changingVowel.present)
        
        return attributedString
    }

    
    func simplePastColored(font: UIFont) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self.verb.simplePast,
                                                         attributes: [.font: font])
        
        // here you change the character to the color that you want
        attributedString.addAttribute(.foregroundColor, value: self.colorChangedVowel, range: self.changingVowel.simplePast)
        
        return attributedString
    }
    
    func pastParticipleColored(font: UIFont) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self.verb.pastParticiple,
                                                         attributes: [.font: font])
        
        // here you change the character to the color that you want
        attributedString.addAttribute(.foregroundColor, value: self.colorChangedVowel, range: self.changingVowel.pastParticiple)
        
        return attributedString
    }
    
    
    /* private function */
    

    /// Helper function let or to delete the pronoun on the conjugated form
    private func formatConjugatedForm(_ verb:String) -> String {
        if pronoun { return "er " + verb}
        else{
             return verb
        }
    }
    
    
    /* to the database beans */
    
    
    func toDbVerb() -> DbVerb{
        return DbVerb(id: self.id, level: self.level, form: self.form,
                      infinitive: self.verb.0, present: self.verb.1,
                      simplePast: self.verb.2, pastParticiple: self.verb.3)
    }
    
    /// If the id
    func toDbVerbTranslations(id: Int64?) -> [DbVerbTranslation] {
        return translations.map({t in
            DbVerbTranslation(id: nil, verbId: id ?? self.id, lang: t.0, translation: t.1)
        })
    }
    
    
    
    func colored() {
        
        
    }

    
}






