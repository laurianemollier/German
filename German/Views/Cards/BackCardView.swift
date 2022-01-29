//
//  BackCardView.swift
//  German
//
//  Created by Lauriane Mollier on 9/27/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct BackCardView: View {
    
    let verb: Verb
    
    var body: some View {
        VStack {
            Text(verb.translation(Lang.en))
            
            Text.verbTemps(verb.tense.infinitive)
            Text.verbTemps(verb.tense.present)
            Text.verbTemps(verb.tense.simplePast)
            Text.verbTemps(verb.tense.pastParticiple)
        }
    }
}

struct BackCardView_Previews: PreviewProvider {
    static var previews: some View {
        BackCardView(verb: Verbs.verbs.first!)
    }
}
