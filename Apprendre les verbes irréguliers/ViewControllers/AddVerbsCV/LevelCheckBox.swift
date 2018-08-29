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
    
    let borderWidth: CGFloat = 3
    var borderColorNotSelected: CGColor!
    let borderColorSelected: CGColor = UIColor.red.cgColor

    
    
    @IBAction func checkBox(_ sender: UIButton) {
        if self.isSelected{
            designNotSelected()
            self.isSelected = false
        }
        else{
            designSelected()
            self.isSelected = true
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
        self.view = loadViewFromNib() as! UIButton?
        self.view.frame = bounds
        self.view.autoresizingMask = [UIViewAutoresizing.flexibleWidth,
                                 UIViewAutoresizing.flexibleHeight]
        
        self.layer.borderWidth = self.borderWidth
        self.layer.cornerRadius = self.frame.height / 2
        self.borderColorNotSelected = self.backgroundColor?.cgColor
        
        
        designNotSelected()
        
        addSubview(view)
        
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIButton
        
        return view
    }
    
    private func designSelected(){
        // Add our border here and every custom setup
        self.layer.borderColor = self.borderColorSelected
    }
    
    private func designNotSelected(){
        
        self.layer.borderColor = self.borderColorNotSelected
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
