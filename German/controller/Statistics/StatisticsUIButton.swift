//
//  StatisticsButton.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 21/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//


import UIKit

@IBDesignable
class StatisticsUIButton: UIButton {
    
    var userProgression: UserProgression!
    var nbrVerb: Int!
    
    private let fontDifference: CGFloat = 3
    private let iconImageView = UIImageView()
    private let nbrVerbLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit(){
        self.addSubview(self.iconImageView)
        self.addSubview(self.nbrVerbLabel)
    }

    
    public func setUp(userProgression: UserProgression, nbrVerb: Int) {
        self.userProgression = userProgression
        self.nbrVerb = nbrVerb

        // TODO
        self.isEnabled = nbrVerb != 0

        let borderHorizontal = self.frame.width * 0.048731
        
        if let image = userProgression.image(){
            // set the icon
//            setUpIcon(image: image, borderHorizontal: borderHorizontal)
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
        self.iconImageView.image = image
        let imgRation: CGFloat = 1
        let imgHeight = self.frame.height * 0.7065

        let imgY = (self.frame.height - imgHeight) / 2
        let imgX = borderHorizontal
        self.iconImageView.frame = CGRect(x: imgX, y: imgY, width: imgHeight * imgRation, height: imgHeight)
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
//        self.setTitle(userProgression.name(), for: .normal)
        
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
