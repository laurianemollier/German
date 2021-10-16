//
//  GermanTabView.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI


// https://medium.com/@karaiskc/programmatic-navigation-in-swiftui-30b75613f285
// https://github.com/matteopuc/swiftui-navigation-stack
struct GermanTabView: View {
    var body: some View {
        TabView {
            RevisionView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
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
        }
        .accentColor(.brandPrimary)
    }
}

struct GermanTabView_Previews: PreviewProvider {
    static var previews: some View {
        GermanTabView()
    }
}
