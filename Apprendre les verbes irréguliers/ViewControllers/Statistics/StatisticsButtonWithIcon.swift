//
//  StatisticsButtonWithIcon.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 21/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

@IBDesignable
class StatisticsButtonWithIcon: UIButton {
    
    let fontDifference: CGFloat = 5
    

    public func setUp(userProgression: UserProgression, nbrVerb: Int) {
        
        let borderHorizontal = self.frame.width * 0.048731
        
        // set the icon
        let imageView = UIImageView(image: userProgression.image())
        let imgRation = imageView.frame.width / imageView.frame.height
        let imgHeight = self.frame.height * 0.7065
        
        let imgY = (self.frame.height - imgHeight) / 2
        let imgX = borderHorizontal
        imageView.frame = CGRect(x: imgX, y: imgY, width: imgHeight * imgRation, height: imgHeight)
        self.addSubview(imageView)
        
        // set the text
        self.titleEdgeInsets.left = self.frame.width * 0.223564
        self.contentHorizontalAlignment = .left
        
     
        // Set label
        let labelWidth = self.frame.width * 0.2
        let labelX = self.frame.width - labelWidth - borderHorizontal
        
        let label = UILabel(frame: CGRect(x: labelX, y: 0, width: labelWidth, height: self.frame.height))
        label.textAlignment = .center
        label.text = String(nbrVerb) + " verbs" // TODO
        
        let fontSizeLabel = (self.titleLabel?.font.pointSize)! - fontDifference
        let labelFont = UIFont(name: (self.titleLabel?.font.fontName)!, size: fontSizeLabel)
        label.font = labelFont
        label.textColor = UIColor(rgb: 0xDD0000)
        self.addSubview(label)
        
        
        
        

        
        // set layer
        self.layer.shadowRadius = 3
        self.layer.shadowColor = UIColor.blue.cgColor
        self.backgroundColor = UIColor.blue
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.cornerRadius = 8
        
    }
    

    


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
