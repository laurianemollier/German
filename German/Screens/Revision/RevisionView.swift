//
//  RevisionView.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct RevisionView: View {
    
    @StateObject var navigation: RevisionNavigationModel = RevisionNavigationModel(state: RevisionNavigationState.home)
    
    var body: some View {
        // https://github.com/matteopuc/swiftui-navigation-stack
        NavigationView{
            switch self.navigation.state {
            case .home:
                RevisionHomeView()
                    .environmentObject(navigation)
            //                    .transition(.move(edge: .trailing))
            //                    .animation(.default)
            case .pickStyle:
                PickRevisionStyleView()
                    .environmentObject(navigation)
            //                    .transition(.move(edge: .trailing))
            //                    .animation(.default)
            case .reviewWithUniqueCard:
                ReviewVerbView()
                    .environmentObject(navigation)
                
            case .reviewWithOneCardForEachTemps:
                ReviewVerbWithMultipleCardView()
                    .environmentObject(navigation)
            }
        }
    }
}

struct RevisionView_Previews: PreviewProvider {
    static var previews: some View {
        RevisionView()
    }
}
