////
////  ReviewCardStyleOneCardForEachTempsView.swift
////  German
////
////  Created by Lauriane Mollier on 10/17/21.
////  Copyright © 2021 Lauriane Mollier. All rights reserved.
////
//
//import SwiftUI
//
//struct ReviewOneCardPerTempsView: View {
//    
//    let verb: Verb
//    
//    @ObservedObject var viewModel: ReviewOneCardPerTempsViewModel
//    @EnvironmentObject var audioToggleViewModel: AudioToggleViewModel
//    
//    var body: some View {
//        //        Text.verbTemps(verb.temps.infinitive)
//        //        Text.verbTemps(verb.temps.present)
//        //        Text.verbTemps(verb.temps.simplePast)
//        //        Text.verbTemps(verb.temps.pastParticiple)
//                
//        FlashcardView<Text, Text>(viewModel: viewModel.flashcard) {
//                    Text("infinitive")
//                } back: {
//                    Text.verbTemps(verb.temps.infinitive)
//                } onTapGestureAction: {
//                        audioToggleViewModel.audioStop()
//                        try audioToggleViewModel.audioPlay(verb: verb, playVerbAudio: PlayVerbAudio.infinitive)
//                }
//    }
//}
//
//struct ReviewOneCardPerTempsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewOneCardPerTempsView(verb: Verbs.verbs.first!, viewModel: ReviewOneCardPerTempsViewModel())
//    }
//}
