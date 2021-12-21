//
//  VerbDetailsView.swift
//  German
//
//  Created by Lauriane Mollier on 10/11/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct LearningVerbDetailsView: View {
    
    @EnvironmentObject var navigation: StatisticsNavigationModel
    let learningVerb: LearningVerb

    var body: some View {
        VStack {
            BackCardView(verb: learningVerb.verb)
            
            if learningVerb.userProgression == UserProgression.notSeenYet {
                Button(action: {
                    addToTheReviewList(learningVerb: learningVerb)
                }, label: {
                    ToChangeButton(
                        title: "Add the verb to the review list",
                        backgroundColor: Color.orange)
                })
            } else {
                Text("Knowledge level for this verb")
                
                VStack{
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
        }, label: {
            UserProgressionButton(userProgression: userProgression)
        })
    }
    
    private func addToTheReviewList(learningVerb: LearningVerb){
        navigation.activeUserProgression = nil
        navigation.activeLearningVerb = nil
        
        do{
            let success = try DAO.shared.addVerbToReviewList(learningVerb: learningVerb)
            if success {
                SpeedLog.print("Sucessly modify all learning verb")
            }
            else{
                SpeedLog.print("One verb was not found")
            }
        }
        catch{
            SpeedLog.print(error)
        }
    }
    
    private func selectNewProgressionLevel(newProgressionLevel: UserProgression){
        navigation.activeUserProgression = nil
        navigation.activeLearningVerb = nil
        
        let (newProgression, dateToReview) = UserProgression.stagnation(newProgressionLevel, reviewedDate: Date())!
        
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
                SpeedLog.print("One verb was not found")
            }
        }
        catch{
            SpeedLog.print(error)
        }
    }
}

struct VerbDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LearningVerbDetailsView(learningVerb: LearningVerb(id: 1, verb: Verbs.verbs.first!))
    }
}
