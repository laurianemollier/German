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
            
            Spacer()
        }
    }
    
    private func userProgressionButton(userProgression: UserProgression) -> NavigationLink<UserProgressionButton, VerbListView> {
        do {
            let verbs = try DAO.shared.select(userProgression: userProgression)
            
            return NavigationLink(destination: VerbListView(userProgression: userProgression)) {
                UserProgressionButton(userProgression: userProgression, verbCount: verbs.count)
            }
            
        } catch {
            SpeedLog.print(error)
            return NavigationLink(destination: VerbListView(userProgression: userProgression)) {
                UserProgressionButton(userProgression: userProgression, verbCount: 0)
            }
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
