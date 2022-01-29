//
//  VerbListCell.swift
//  German
//
//  Created by Lauriane Mollier on 10/10/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

enum VerbListCellViewMode: String {
    case expanded
    case compressed
    
    static let allValues = [expanded, compressed]
}

extension VerbListCellViewMode: Identifiable {
    var id: RawValue { rawValue }
}

struct VerbListCell: View {
    
    let verb: Verb
    let viewMode: VerbListCellViewMode
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text.verbTemps(verb.tense.infinitive)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text.verbTemps(verb.tense.present)
                Text.verbTemps(verb.tense.simplePast)
                Text.verbTemps(verb.tense.pastParticiple)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(verb.translation(Lang.en))
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
        VerbListCell(verb: Verbs.verbs.first!, viewMode: VerbListCellViewMode.expanded)
    }
}
