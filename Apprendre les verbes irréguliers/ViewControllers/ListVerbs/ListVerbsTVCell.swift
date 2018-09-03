//
//  ListVerbsTVCell.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 21/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class ListVerbsTVCell: UITableViewCell {

    var userLearningVerb: UserLearningVerb!
    
    @IBOutlet var conainerView: UIView!
    @IBOutlet weak var infinitiveLabel: UILabel!
    @IBOutlet weak var traductionLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var presentLabel: UILabel!
    @IBOutlet weak var simplePastLabel: UILabel!
    @IBOutlet weak var pastParticipleLabel: UILabel!
    
    
    
    @IBOutlet weak var informationLabel: UILabel!
    

    func setUp(userLearningVerb: UserLearningVerb){
        self.userLearningVerb = userLearningVerb
        self.infinitiveLabel.text = userLearningVerb.verb.infinitive()
        self.presentLabel.text = userLearningVerb.verb.present()
        self.simplePastLabel.text = userLearningVerb.verb.simplePast()
        self.pastParticipleLabel.text = userLearningVerb.verb.pastParticiple()
        self.traductionLabel.text = userLearningVerb.verb.translation(Lang.fr) // TODO
        
        self.levelLabel.text = userLearningVerb.verb.level.rawValue
        
        if userLearningVerb.userProgression.isNotInReviewList(){
            self.informationLabel.isHidden = true
        }
        else{
            self.informationLabel.isHidden = false
        }

        self.conainerView.layer.cornerRadius = 7
        self.informationLabel.layer.cornerRadius = 5
        self.informationLabel.layer.borderWidth = 1
        self.informationLabel.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
