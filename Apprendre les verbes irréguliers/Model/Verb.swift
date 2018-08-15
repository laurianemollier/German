//
//  Verb.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 09/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import AVFoundation


enum Lang: String{
    case DeviceLanguage = "DeviceLanguage"
    case fr = "fr"
    case en = "en"
    case es = "es"
    case ru = "ru"
    case zh = "zh-Hant" // chinees trad
    case ar = "ar"
    case it = "it"
    case ja = "ja"
    
    static let allValues = [DeviceLanguage, fr, en, es, ru, zh, ar, it, ja]
}


/// Each verb belongs to a conjugation's form
public enum Form: String { // 11
    case aiea = "a–ie(i)–a"
    case aua = "a-u-a"
    case eae = "e-a-e"
    case eao = "e-a-o"
    case eiieie = "ei-ie-ie"
    case eiii = "ei-i-i"
    case iao = "i-a-o"
    case iau = "i-a-u"
    case ieoo = "ie(e)-o-o"
    case undefine = "undefine"
    case weak = "weak"
    
    static let allValues = [aiea, aua, eae, eao, eiieie, eiii, iao, iau, ieoo, undefine, weak]
}


/// Each verb belong to a level
public enum Level: String{
    case A2 = "A2"
    case B1 = "B1"
    case B2 = "B2"
    case C1 = "C1"
    case All = "All"
    
    static let allValues = [A2, B1, B2, C1, All]
}



/// A verb to learn
class Verb{
    
    /// The id for the verb
    let id: Int
    
    /// The level at which you are supposed to learn this verb.
    let level: Level
    
    /// The form to which the verb belongs.
    let form: Form
    
    /// The differents temps of this verb
    /// (infinitive, present, simple past, past participle)
    fileprivate let verb: (String, String, String, String)
    
    /// The translation avalable in each language
    fileprivate var translations = [Lang:String]()
    
    /// If true, display the pronoun while conjugating the verb
    fileprivate var pronoun: Bool = false
    

    /* Constructor */
    
    /// Create a verb to learn
    ///
    /// - Parameters:
    ///     - level: The level at which you are supposed to learn this verb.
    ///     - form: The form to which the verb belongs.
    ///     - verb: The differents temps of this verb (infinitive, present, simple past, past participle)
    ///     - translations: The translation avalable in each language
    ///
    /// - Returns: A verb
    init(id: Int, level: Level, form: Form, verb: (String, String, String, String), translations: [(Lang, String)]){
        self.id = id
        self.level = level
        self.form = form
        self.verb = verb
        
        translations.forEach({
            self.translations[$0] = $1
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
    
    
    /* private function */
    

    /// Helper function let or to delete the pronoun on the conjugated form
    fileprivate func formatConjugatedForm(_ verb:String) -> String {
        if pronoun { return verb}
        else{
             return (verb as NSString).substring(from: 3)
        }
    }
    
}






