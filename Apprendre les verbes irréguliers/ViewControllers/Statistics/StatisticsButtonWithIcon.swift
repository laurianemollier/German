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

    public func setUp(userProgression: UserProgression, nbrVerb: Int) throws {
        
        
    }
    
    
    
    public func setUpee(img: UIImage){
        
        // set the icon
        let imageView = UIImageView(image: img)
        let imgRation = imageView.frame.width / imageView.frame.height
        let imgHeight = self.frame.height * 0.7065
        
        let imgY = (self.frame.height - imgHeight) / 2
        imageView.frame = CGRect(x: self.frame.width * 0.048731, y: imgY, width: imgHeight * imgRation, height: imgHeight)
        self.addSubview(imageView)
        
        // set the label
        
        self.titleEdgeInsets.left = self.frame.width * 0.223564
        self.contentHorizontalAlignment = .left
        
        
        // set layer
        self.layer.shadowRadius = 3
//        self.layer.shadowColor = darkGray.cgColor
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
