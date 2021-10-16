//
//  VerbDetailsView.swift
//  German
//
//  Created by Lauriane Mollier on 10/11/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct LearningVerbDetailsView: View {
    
    let learningVerb: LearningVerb
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        VStack {
            BackCardView(verb: learningVerb.verb)
            
            if learningVerb.userProgression == UserProgression.notSeenYet {
                Button(action: {
                    selectNewProgressionLevel(newProgressionLevel: UserProgression.level1)
                    isShowingDetail = false
                }, label: {
                    ToChangeButton(
                        title: "Add the verb to the review list",
                        backgroundColor: Color.orange)
                })
            } else {
                Text("Niveau de connaissance du verbe")
                
                VStack{
                    userProgressionButton(userProgression: UserProgression.notSeenYet)
                    userProgressionButton(userProgression: UserProgression.level1)
                    userProgressionButton(userProgression: UserProgression.level2)
                    userProgressionButton(userProgression: UserProgression.level3)
                    userProgressionButton(userProgression: UserProgression.level4)
                    userProgressionButton(userProgression: UserProgression.level5)
                    userProgressionButton(userProgression: UserProgression.level6)
                    userProgressionButton(userProgression: UserProgression.level7)
                    userProgressionButton(userProgression: UserProgression.level8)
                }
            }
        }
    }
    
    private func userProgressionButton(userProgression: UserProgression) -> Button<UserProgressionButton> {
        return Button(action: {
            selectNewProgressionLevel(newProgressionLevel: userProgression)
            isShowingDetail = false
        }, label: {
            UserProgressionButton(userProgression: userProgression)
        })
    }
    
    private func selectNewProgressionLevel(newProgressionLevel: UserProgression){
        let (newProgression, dateToReview) =
        newProgressionLevel.stagnation(reviewedDate: Date())!
        
        do{
            
            let userLearningVerb = LearningVerb(id: learningVerb.id,
                                                verb: learningVerb.verb,
                                                dateToReview: dateToReview,
                                                userProgression: newProgression)
            let success = try DAO.shared.update(learningVerb: userLearningVerb.toDbUserLearningVerb())
            if success {
                SpeedLog.print("Sucessly modify all learning verb")
            }
            else{
                // TODO
                SpeedLog.print("One verb was not found")
            }
        }
        catch{
            // TODO
            SpeedLog.print(error)
        }
    }
}

struct VerbDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LearningVerbDetailsView(learningVerb: LearningVerb(id: 1, verb: Verbs.verbs.first!), isShowingDetail: .constant(true))
    }
}
