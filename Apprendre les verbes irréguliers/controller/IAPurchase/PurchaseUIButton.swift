//
//  PurchaseUIButton.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 09/09/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable
class PurchaseUIButton: UIButton {
    
    
    func setUp(price: String) {
        setUpBadge(price: price)
        setLabelExplaination()
    }
    
    private func setUpBadge(price: String){
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Badge"))
        let imgRation = imageView.frame.width / imageView.frame.height
        let imgHeight = self.frame.height * 0.55
        let imgWidth = imgHeight * imgRation
        
        let imgX = self.frame.width * 0.06
        imageView.frame = CGRect(x: imgX, y: -1, width: imgWidth, height: imgHeight)
        self.addSubview(imageView)
        
        let imgXOffset = imgWidth * 0.23
        let imgYOffset = imgHeight * 0.25
        let priceLabel = UILabel()
        priceLabel.frame = CGRect(x: imgX + imgXOffset, y: 0, width: imgWidth - imgXOffset, height: imgHeight - imgYOffset)
        priceLabel.text = price
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.appBoldFontWith(size: 12)
        
        self.addSubview(priceLabel)
        
    }
    
    
    private func setLabelExplaination(){
        let label = UILabel()
        
        let yOffset = self.frame.height * 0.1
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height + yOffset)
        label.font = UIFont.appBoldFontWith(size: 20)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = self.title(for: .normal)
//        label.backgroundColor = UIColor.blue
        
        self.addSubview(label)
    }
    
    
    

}
