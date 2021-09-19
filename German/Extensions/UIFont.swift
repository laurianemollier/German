//
//  UIFont.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 24/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//


/// Sources: https://medium.com/@AttiaMo/custom-fonts-in-ios-apps-global-settings-and-localizations-e6193918e35c
import Foundation
import UIKit


extension UIFont {
    class func  appBoldFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "RobotoSlab-Bold", size: size)!
    }
    class func appRegularFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "RobotoSlab-Regular", size: size)!
    }
    class func appThinFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "RobotoSlab-Thin", size: size)!
    }
    class func appLightFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "RobotoSlab-Light", size: size)!
    }
}


extension UILabel {
    var substituteFontName : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of:"-Bd") == nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    var substituteFontNameBold : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of:"-Bd") != nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
}
//extension UITextField {
//    var substituteFontName : String {
//        get { return self.font!.fontName }
//        set { self.font = UIFont(name: newValue, size: (self.font?.pointSize)!) }
//    }
//}





