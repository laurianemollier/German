//
//  StatisticsView.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
    
    var body: some View {
        NavigationView {
            VStack{
                statisticsButton(userProgression: UserProgression.notSeenYet)
                statisticsButton(userProgression: UserProgression.level1)
                statisticsButton(userProgression: UserProgression.level2)
                statisticsButton(userProgression: UserProgression.level3)
                statisticsButton(userProgression: UserProgression.level4)
                statisticsButton(userProgression: UserProgression.level5)
                statisticsButton(userProgression: UserProgression.level6)
                statisticsButton(userProgression: UserProgression.level7)
                statisticsButton(userProgression: UserProgression.level8)
            }
            
            Spacer()
        }
    }
    
    private func statisticsButton(userProgression: UserProgression) -> NavigationLink<StatisticsButton, Text> {
        do {
            let verbs = try DAO.shared.select(userProgression: userProgression)
            
            return NavigationLink(destination: Text("Second View")) {
                StatisticsButton(userProgression: userProgression, verbCount: verbs.count)
            }
            
        } catch {
            SpeedLog.print(error)
            return NavigationLink(destination: Text("Second View")) {
                StatisticsButton(userProgression: userProgression, verbCount: 0)
            }
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
