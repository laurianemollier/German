//
//  FrontCardView.swift
//  German
//
//  Created by Lauriane Mollier on 9/27/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct FrontCardView: View {
    
    let verb: Verb
    
    var body: some View {
        VStack {
            Text(verb.translation(Lang.fr))
        }
    }
}

struct FrontCardView_Previews: PreviewProvider {
    static var previews: some View {
        FrontCardView(verb: Verbs.verbs.first!)
    }
}
