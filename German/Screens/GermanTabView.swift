//
//  GermanTabView.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

// https://medium.com/@karaiskc/programmatic-navigation-in-swiftui-30b75613f285
// https://github.com/matteopuc/swiftui-navigation-stack
struct GermanTabView: View {
    
    @StateObject var statisticsNavigation = StatisticsNavigationModel()
    @StateObject var revisionNavigation = RevisionNavigationModel()
    
    var body: some View {
        TabView {
            RevisionHomeView(
                store: Store(
                    initialValue: RevisionHomeState(),
                    reducer: revisionHomeReducer)
            )
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .environmentObject(revisionNavigation)
            
            LearnView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
            
            StatisticsView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("Order")
                }
                .environmentObject(statisticsNavigation)
        }
        .accentColor(.brandPrimary)
    }
}

struct GermanTabView_Previews: PreviewProvider {
    static var previews: some View {
        GermanTabView()
    }
}
