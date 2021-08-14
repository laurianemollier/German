//
//  Background3.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/09/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

@IBDesignable
class Background3: UIView {

     @IBOutlet weak var view: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    
    func setup() {
        self.view = loadViewFromNib() as UIView?
        self.view.frame = bounds
        self.view.autoresizingMask = [UIViewAutoresizing.flexibleWidth,
                                      UIViewAutoresizing.flexibleHeight]

        addSubview(view)
        self.layer.cornerRadius = self.view.frame.height / 2
        
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}
