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
            Text(verb.translation(Lang.fr))
            
            Text.verbTemps(verb.temps.infinitive)
            Text.verbTemps(verb.temps.present)
            Text.verbTemps(verb.temps.simplePast)
            Text.verbTemps(verb.temps.pastParticiple)
            
        }
    }
}

struct BackCardView_Previews: PreviewProvider {
    static var previews: some View {
        BackCardView(verb: Verbs.verbs.first!)
    }
}
