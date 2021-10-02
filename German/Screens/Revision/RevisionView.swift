//
//  RevisionView.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct RevisionView: View {
    
    @State var navigationState: RevisionNavigationState? = RevisionNavigationState.home
    
    var body: some View {
        // https://github.com/matteopuc/swiftui-navigation-stack
        NavigationView{
            switch self.navigationState {
            case .home:
                RevisionHomeView(navigationState: $navigationState)
            //                    .transition(.move(edge: .trailing))
            //                    .animation(.default)
            case .pickStyle:
                PickRevisionStyleView(navigationState: $navigationState)
            //                    .transition(.move(edge: .trailing))
            //                    .animation(.default)
            case .review:
                ReviewVerbView(navigationState: $navigationState)
            //                    .transition(.move(edge: .trailing))
            //                    .animation(.default)
            default:
                RevisionHomeView(navigationState: $navigationState)
            //                    .transition(.move(edge: .trailing))
            //                    .animation(.default)
            }
        }
    }
}

struct RevisionView_Previews: PreviewProvider {
    static var previews: some View {
        RevisionView()
    }
}
