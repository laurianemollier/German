//
//  ReviewView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct ReviewVerbView: View {
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    @StateObject var viewModel: ReviewVerbViewModel
    
    var body: some View {
        VStack {
            if let currentVerb = viewModel.currentLearningVerb {
                FlashcardView<FrontCardView, BackCardView>(flipped: $viewModel.flipped) {
                    FrontCardView(verb: currentVerb.verb) // TODO: lolo
                } back: {
                    BackCardView(verb: currentVerb.verb) // TODO: lolo
                } onTapGestureAction: {
                    SpeedLog.print("Audio")
                }
                
                if viewModel.flipped {
                    ReviewRateProgressionView().environmentObject(viewModel)
                } else {
                    Button {
                        viewModel.flipped = true
                    } label: {
                        Image("RVTurnButton")
                    }
                }
            }
        }
        .onAppear {
            viewModel.getVerbToReview()
        }
        .overlay(Button {
            viewModel.navigationState = RevisionNavigationState.pickStyle
        } label: {
            XDismissButton()
        }, alignment: .topTrailing)
    }
}

struct ReviewVerbView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewVerbView(viewModel: ReviewVerbViewModel(navigationState: .constant(RevisionNavigationState.review)))
    }
}
