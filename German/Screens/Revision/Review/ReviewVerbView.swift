//
//  ReviewView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

// https://stackoverflow.com/questions/62512547/in-swiftui-in-a-foreach0-3-animate-the-tapped-button-only-not-all-3-a
struct ReviewVerbView: View {
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    @EnvironmentObject var navigation: RevisionNavigation
    
    @StateObject var viewModel: ReviewVerbViewModel = ReviewVerbViewModel()
    @StateObject var flashcardViewModel: FlashcardViewModel = FlashcardViewModel()
    
    var body: some View {
        VStack {
            if let currentVerb = viewModel.currentLearningVerb {
                FlashcardView<FrontCardView, BackCardView>(viewModel: flashcardViewModel) {
                    FrontCardView(verb: currentVerb.verb)
                } back: {
                    BackCardView(verb: currentVerb.verb)
                } onTapGestureAction: {
                    SpeedLog.print("Audio")
                }
                
                if flashcardViewModel.flipped {
                    ReviewRateProgressionView(viewModel: viewModel)
                } else {
                    Button {
                        flashcardViewModel.flipFlashcard()
                    } label: {
                        Image("RVTurnButton")
                    }
                }
            }
        }
        .onAppear {
            viewModel.getVerbToReview()
            viewModel.setAction(
                onNextVerb: {
                    flashcardViewModel.flipped = false
                })
            
            viewModel.setAction(
                onEndRevisionSession: {
                    navigation.state = RevisionNavigationState.home
                })
        }
        .overlay(Button {
            navigation.state = RevisionNavigationState.pickStyle
        } label: {
            XDismissButton()
        }, alignment: .topTrailing)
    }
}

//struct ReviewVerbView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewVerbView(
//            viewModel: ReviewVerbViewModel(navigationState: .constant(RevisionNavigationState.review))
//        )
//    }
//}
