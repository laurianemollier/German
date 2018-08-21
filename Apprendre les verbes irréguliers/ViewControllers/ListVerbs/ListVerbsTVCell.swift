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
    
    @IBOutlet weak var infinitiveLabel: UILabel!
    @IBOutlet weak var traductionLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    

    func setUp(userLearningVerb: UserLearningVerb){
        self.userLearningVerb = userLearningVerb
        self.infinitiveLabel.text = userLearningVerb.verb.infinitive()
        
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
