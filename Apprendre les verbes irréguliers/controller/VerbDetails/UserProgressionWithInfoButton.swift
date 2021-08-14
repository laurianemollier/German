//
//  UserProgressionWithInfoButton.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 13/10/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class UserProgressionWithInfoButton: UserProgressionButton {
    
    var nbrVerb: Int!
    private let fontDifference: CGFloat = 3
    
    private let nbrVerbLabel = UILabel()
    
    override func commonInit(){
        super.commonInit()
        self.addSubview(self.nbrVerbLabel)
    }

    public func setUp(userProgression: UserProgression, nbrVerb: Int) {
        super.setUp(userProgression: userProgression)
        self.nbrVerb = nbrVerb
        
        // TODO
        self.isEnabled = nbrVerb != 0
        
        // Set label on the left
        setUpLabel(nbrVerb: nbrVerb, borderHorizontal: borderHorizontal)
    }
    
    
    // Set label on the left
    private func setUpLabel(nbrVerb: Int, borderHorizontal: CGFloat){
        let labelWidth = self.frame.width * 0.5
        let labelX = self.frame.width - labelWidth - borderHorizontal
        
        self.nbrVerbLabel.frame = CGRect(x: labelX, y: 0, width: labelWidth, height: self.frame.height)
        self.nbrVerbLabel.textAlignment = .right
        if nbrVerb == 0 || nbrVerb == 1{
            self.nbrVerbLabel.text = String(nbrVerb) + " verbe" // TODO
        }
        else{
            self.nbrVerbLabel.text = String(nbrVerb) + " verbes" // TODO
        }
        
        
        let fontSizeLabel = (self.titleLabel?.font.pointSize)! - fontDifference
        self.nbrVerbLabel.font = UIFont.appRegularFontWith(size: fontSizeLabel)
        self.nbrVerbLabel.textColor = UIColor(rgb: 0xDD0000)
    }


}
