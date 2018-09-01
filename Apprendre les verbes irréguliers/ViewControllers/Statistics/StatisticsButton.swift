//
//  StatisticsButton.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 21/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//


import UIKit

@IBDesignable
class StatisticsButton: UIButton {
    
    
    let fontDifference: CGFloat = 3
    
    public func setUp(userProgression: UserProgression, nbrVerb: Int) {
        
        let borderHorizontal = self.frame.width * 0.048731
        
        if let image = userProgression.image(){
            // set the icon
            setUpIcon(image: image, borderHorizontal: borderHorizontal)
            setUpText(withIcon: true, userProgression: userProgression, borderHorizontal: borderHorizontal)
        }
        else{
            // No icon
            setUpText(withIcon: false, userProgression: userProgression, borderHorizontal: borderHorizontal)
        }
        
        // Set label on the left
        setUpLabel(nbrVerb: nbrVerb, borderHorizontal: borderHorizontal)
        
        // set layer
        setUpLayer()
        
        
    }
    
    
    
    // set the icon
    private func setUpIcon(image: UIImage, borderHorizontal: CGFloat){
        let imageView = UIImageView(image: image)
        let imgRation = imageView.frame.width / imageView.frame.height
        let imgHeight = self.frame.height * 0.7065
        
        let imgY = (self.frame.height - imgHeight) / 2
        let imgX = borderHorizontal
        imageView.frame = CGRect(x: imgX, y: imgY, width: imgHeight * imgRation, height: imgHeight)
        self.addSubview(imageView)
    }
    
    // set the text
    private func setUpText(withIcon: Bool, userProgression: UserProgression, borderHorizontal: CGFloat){
        self.contentHorizontalAlignment = .left
        if withIcon{
            self.titleEdgeInsets.left = self.frame.width * 0.19
        }
        else{
            self.titleEdgeInsets.left = borderHorizontal
        }
        self.setTitle(userProgression.name(), for: .normal)
        
    }
    
    
    // Set label on the left
    private func setUpLabel(nbrVerb: Int, borderHorizontal: CGFloat){
        let labelWidth = self.frame.width * 0.5
        let labelX = self.frame.width - labelWidth - borderHorizontal
        
        let label = UILabel(frame: CGRect(x: labelX, y: 0, width: labelWidth, height: self.frame.height))
        label.textAlignment = .right
        if nbrVerb == 0 || nbrVerb == 1{
           label.text = String(nbrVerb) + " verbe" // TODO
        }
        else{
            label.text = String(nbrVerb) + " verbes" // TODO
        }
        
        
        let fontSizeLabel = (self.titleLabel?.font.pointSize)! - fontDifference
        label.font = UIFont.appRegularFontWith(size: fontSizeLabel)
        label.textColor = UIColor(rgb: 0xDD0000)
        self.addSubview(label)
    }
    
    
    
    private func setUpLayer(){
//        self.titleLabel?.font = UIFont.appBoldFontWith(size: self.titleLabel?.font.pointSize)
        
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor(rgb: 0xa68282).cgColor
        self.backgroundColor = UIColor.white
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.cornerRadius = 7
        
        
    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */

}
