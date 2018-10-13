//
//  UserProgressionButton.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 13/10/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class UserProgressionButton: UIButton {

    var userProgression: UserProgression!
    
    private let iconImageView = UIImageView()
    private let nbrVerbLabel = UILabel()
    
    var borderHorizontal: CGFloat!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit(){
        self.addSubview(self.iconImageView)
    }
    
    
    public func setUp(userProgression: UserProgression) {
        self.userProgression = userProgression
        
        self.borderHorizontal = self.frame.width * 0.048731
        
        if let image = userProgression.image(){
            // set the icon
            setUpIcon(image: image, borderHorizontal: borderHorizontal)
            setUpText(withIcon: true, userProgression: userProgression, borderHorizontal: borderHorizontal)
        }
        else{
            // No icon
            setUpText(withIcon: false, userProgression: userProgression, borderHorizontal: borderHorizontal)
        }

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
        self.setTitle(userProgression.name(), for: .normal)
        
    }

    
    
    
    private func setUpLayer(){
        //        self.titleLabel?.font = UIFont.appBoldFontWith(size: self.titleLabel?.font.pointSize)
        
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor(rgb: 0xa68282).cgColor
        self.backgroundColor = UIColor.white
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.cornerRadius = 7
        
        
    }

}
