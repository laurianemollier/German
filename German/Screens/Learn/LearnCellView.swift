//
//  LearnCellView.swift
//  German
//
//  Created by Lauriane Mollier on 12/6/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct LearnCellView: View {
    
    @State var learningVerb: LearningVerb
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text.verbTemps(learningVerb.verb.temps.infinitive)
                    .font(.title2)
                    .fontWeight(.semibold)

                Text.verbTemps(learningVerb.verb.temps.present)
                Text.verbTemps(learningVerb.verb.temps.simplePast)
                Text.verbTemps(learningVerb.verb.temps.pastParticiple)
                
                Spacer()
                Text(learningVerb.verb.translation(Lang.en)).foregroundColor(Color.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                
                if learningVerb.userProgression == UserProgression.notSeenYet {
                    Button(action: {
                        do{
                            let success = try DAO.shared.addVerbToReviewList(learningVerb: learningVerb)
                            if success {
                                SpeedLog.print("Sucessly add verb to the review list")
                            }
                            else{
                                SpeedLog.print("One verb was not found")
                            }
                        }
                        catch{
                            SpeedLog.print(error)
                        }
                    }, label: {
                        ToChangeButton(
                            title: "Learn",
                            backgroundColor: Color.green)
                    })
                } else {
                    Button(action: {
                        do{
                            let success = try DAO.shared.removeVerbFromReviewList(learningVerb: learningVerb)
                            if success {
                                SpeedLog.print("Sucessly remove verb to the review list")
                            }
                            else{
                                SpeedLog.print("One verb was not found")
                            }
                        }
                        catch{
                            SpeedLog.print(error)
                        }
                    }, label: {
                        ToChangeButton(
                            title: "Remove",
                            backgroundColor: Color.red)
                    })
                }
            }
        }.padding(20)
    }
}

//struct LearnCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        LearnCellView()
//    }
//}
