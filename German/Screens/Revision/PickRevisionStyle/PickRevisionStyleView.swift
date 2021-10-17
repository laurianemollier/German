//
//  PickRevisionStyleView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct PickRevisionStyleView: View {
    
    @EnvironmentObject var navigation: RevisionNavigation
    
    var body: some View {
        NavigationView{
            VStack{
                RevisionStyleView(
                    label: "Review all temps together",
                    image: Image(systemName: "xmark"),
                    action: {
                        navigation.state = RevisionNavigationState.reviewWithUniqueCard
                    }
                )
                .padding(.bottom, 60)
                
                RevisionStyleView(
                    label: "Review temps 1 by 1",
                    image: Image(systemName: "xmark"),
                    action: {
                        navigation.state = RevisionNavigationState.reviewWithOneCardForEachTemps
                    }
                )
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {
            navigation.state = RevisionNavigationState.home
        }))
    }
}

struct PickRevisionStyleView_Previews: PreviewProvider {
    static var previews: some View {
        PickRevisionStyleView()
    }
}
