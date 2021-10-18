//
//  RepeatRevisionButton.swift
//  German
//
//  Created by Lauriane Mollier on 10/2/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

// TODO: lolo
struct ToChangeButton: View {
    
    let title: LocalizedStringKey
    
    let backgroundColor: Color
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(10)
            .frame(height: 50)
            .foregroundColor(.white)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}

struct ToChangeButton_Previews: PreviewProvider {
    static var previews: some View {
        ToChangeButton(
            title: "1 semaine",
            backgroundColor: Color.brandPrimary
        )
    }
}
