//
//  Lang.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
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
