//
//  GermanTabView.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct GermanTabView: View {
    
    @State var tabSelection: Tabs = .tab1
    
    enum Tabs{
        case tab1, tab2, tab3
    }
    
    var body: some View {
        NavigationView{
            TabView(selection: $tabSelection){
                RevisionHomeView(store: Store(
                    initialState: RevisionHomeState(),
                    reducer: revisionHomeReducer,
                    environment: RevisionHomeEnvironment(
                        mainQueue: .main
                    )
                ))
                    .tag(Tabs.tab1)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                
                VerbListView(store: Store(
                    initialState: VerbListState.loading,
                    reducer: verbListReducer,
                    environment: ()
                ))
                    .tag(Tabs.tab2)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Account")
                    }
                
                StatisticsView(store: Store(
                    initialState: StatisticsState.loading,
                    reducer: statisticsReducer,
                    environment: ()
                ))
                    .tag(Tabs.tab3)
                    .tabItem {
                        Image(systemName: "bag")
                        Text("Order")
                    }
            }
            .accentColor(.brandPrimary)
        }
    }
}

struct GermanTabView_Previews: PreviewProvider {
    static var previews: some View {
        GermanTabView()
    }
}
