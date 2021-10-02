//
//  Audio.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 06/09/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import UIKit


final class Audio{
    
    private let key = "org.lauriane-mollier.irregular-verbs.german" + "audio"
    
    static let shared = Audio()
    
    private init(){}
    
    func on(){
        UserDefaults.standard.setValue(true, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func off(){
        UserDefaults.standard.setValue(false, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func isOn() -> Bool {
        if let audio = UserDefaults.standard.object(forKey: key) as? Bool {
            return audio
        }else{
            return true
        }
    }
}


