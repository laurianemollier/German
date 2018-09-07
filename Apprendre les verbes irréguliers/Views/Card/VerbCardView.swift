//
//  BackwardCardView.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 21/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

//@IBDesignable
class VerbCardView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    var verb: Verb!
    
    @IBOutlet weak var translationLabel: UILabel!
    
    @IBOutlet weak var infinitiveLabel: UILabel!
    
    @IBOutlet weak var presentLabel: UILabel!
    
    @IBOutlet weak var simplePastLabel: UILabel!
    
    @IBOutlet weak var pastParticipleLabel: UILabel!
    
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    func commonInit(){
        Bundle.main.loadNibNamed("VerbCardView", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
    func setup(verb: Verb, backward: Bool) {
        self.verb = verb
        
        self.translationLabel.text = verb.translation(Lang.fr)
        self.infinitiveLabel.attributedText = verb.infinitiveColored(font: self.infinitiveLabel.font)
        self.presentLabel.attributedText = verb.presentColored(font: self.presentLabel.font)
        self.simplePastLabel.attributedText = verb.simplePastColored(font: self.simplePastLabel.font)
        self.pastParticipleLabel.attributedText = verb.pastParticipleColored(font: self.pastParticipleLabel.font)
        
        if !backward{
            self.infinitiveLabel.isHidden = true
            self.presentLabel.isHidden = true
            self.simplePastLabel.isHidden = true
            self.pastParticipleLabel.isHidden = true
        }
        
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
