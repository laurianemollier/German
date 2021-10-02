//
//  RevisionStyleView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct RevisionStyleView: View {

    let label: LocalizedStringKey
    let image: Image
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                CallToActionButton(title: label)
            }
            .padding(.bottom, 20)

            image
        }
    }
}

struct RevisionStyleView_Previews: PreviewProvider {
    static var previews: some View {
        RevisionStyleView(
            label: "Pick your revision style",
            image: Image(systemName: "xmark"),
            action: {}
        )
    }
}
