//
//  ReviewView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct ReviewVerbView: View {
    
    @Binding var navigationState: RevisionNavigationState?
    
    var body: some View {
        VStack {
            FlashcardView<FrontCardView, BackCardView> {
                FrontCardView()
            } back: {
                BackCardView(verb: Verbs.verbs.first!) // TODO: lolo
            }
            
            Button {
                navigationState = RevisionNavigationState.home
            } label: {
                CallToActionButton(title: "Finish to review")
            }
        }
        .overlay(Button {
            navigationState = RevisionNavigationState.pickStyle
        } label: {
            XDismissButton()
        }, alignment: .topTrailing)
    }
}

struct ReviewVerbView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewVerbView(navigationState: .constant(RevisionNavigationState.review))
    }
}
