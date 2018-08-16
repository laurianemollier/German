//
//  LevelCheckBox.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 15/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class LevelCheckBox: UIButton {

    @IBAction func checkBox(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            super.setTitle("crrrr", for: .normal)
            super.setTitle(".ssssss", for: .selected)
            print("selected")
        }
        else{
            sender.isSelected = true
            super.setTitle("aaaaaa", for: .normal)
            super.setTitle(".selected true", for: .selected)
            print("not")
        }
    }
    
    // Connect the custom button to the custom class
    @IBOutlet weak var view: UIButton!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    
    func setup() {
        view = loadViewFromNib() as! UIButton?
        view.frame = bounds
        
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth,
                                 UIViewAutoresizing.flexibleHeight]
        
        addSubview(view)
        
        // Add our border here and every custom setup
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.green.cgColor
        view.titleLabel!.font = UIFont.systemFont(ofSize: 40)
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIButton
        
        return view
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
