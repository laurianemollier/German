//
//  VerbListCell.swift
//  German
//
//  Created by Lauriane Mollier on 10/10/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct VerbListCell: View {
    
    let verb: Verb
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text.verbTemps(verb.temps.infinitive)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text.verbTemps(verb.temps.present)
                Text.verbTemps(verb.temps.simplePast)
                Text.verbTemps(verb.temps.pastParticiple)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(verb.translation(Lang.fr))
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                Text(verb.level.rawValue)
                    .foregroundColor(Color.brandPrimary)
                    .font(.title)
                    .fontWeight(.bold)
            }
        }.padding(20)
       
    }
}

struct VerbListCell_Previews: PreviewProvider {
    static var previews: some View {
        VerbListCell(verb: Verbs.verbs.first!)
    }
}
