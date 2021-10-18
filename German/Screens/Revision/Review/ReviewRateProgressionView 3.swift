//
//  ReviewRateProgressionView.swift
//  German
//
//  Created by Lauriane Mollier on 10/3/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct ReviewRateProgressionView: View {
    
    let audioToggleViewModel: AudioToggleViewModel
    @ObservedObject var viewModel: ReviewVerbViewModel
    
    var body: some View {
        if let progression = viewModel.currentLearningVerb?.userProgression{
            VStack {
                Text("To repeat in")
                
                HStack{
                    Button {
                        do {
                        try viewModel.regress()
                            audioToggleViewModel.audioStop()
                        }
                        catch {
                            SpeedLog.print(error)
                        }
                    } label: {
                        ToChangeButton(title: progression.regressionName()!, // TODO
                                             backgroundColor: Color.red)
                    }
                    
                    Button {
                        do {
                            try viewModel.stagnate()
                            audioToggleViewModel.audioStop()
                        }
                        catch {
                            SpeedLog.print(error)
                        }
                        
                    } label: {
                        ToChangeButton(
                            title: progression.stagnationName()!, // TODO
                            backgroundColor: Color.orange)
                    }
                    
                    Button {
                        do {
                            try viewModel.progress()
                            audioToggleViewModel.audioStop()
                        }
                        catch {
                            SpeedLog.print(error)
                        }
                    } label: {
                        ToChangeButton(
                            title: progression.progressionName()!, // TODO
                            backgroundColor: Color.green)
                    }
                }
            }
            }
    }
}

//struct ReviewRateProgressionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewRateProgressionView(viewModel: ReviewVerbViewModel(navigationState: .constant(RevisionNavigationState.review)))
//    }
//}
