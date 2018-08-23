//
//  Background2.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 23/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class Background2: UIView {

    @IBOutlet var contentView: UIView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("Background2", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
