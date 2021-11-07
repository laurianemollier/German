//
//  LearnView.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import AVFoundation

struct LearnView: View {
    
    @StateObject var statisticsNavigationModel = StatisticsNavigationModel()
    
    var body: some View {
        NavigationView {
            VerbListView(userProgression: nil)
                .environmentObject(statisticsNavigationModel)
        }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}
