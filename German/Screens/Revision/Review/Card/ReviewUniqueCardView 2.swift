////
////  ReviewUniqueCardView.swift
////  German
////
////  Created by Lauriane Mollier on 10/17/21.
////  Copyright © 2021 Lauriane Mollier. All rights reserved.
////
//
//import SwiftUI
//
//struct ReviewUniqueCardView: View {
//    
//    let verb: Verb
//    
//    @ObservedObject var viewModel: ReviewUniqueCardViewModel
//    @EnvironmentObject var audioToggleViewModel: AudioToggleViewModel
//    
//    var body: some View {
//        FlashcardView<FrontCardView, BackCardView>(viewModel: viewModel.flashcard) {
//            FrontCardView(verb: verb)
//        } back: {
//            BackCardView(verb: verb)
//        } onTapGestureAction: {
//                audioToggleViewModel.audioStop()
//                try audioToggleViewModel.audioPlay(verb: verb, playVerbAudio: PlayVerbAudio.all)
//        }
//    }
//}
//
//struct ReviewUniqueCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewUniqueCardView(verb: Verbs.verbs.first!, viewModel: ReviewUniqueCardViewModel())
//    }
//}
