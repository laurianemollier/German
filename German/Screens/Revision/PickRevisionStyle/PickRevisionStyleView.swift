//
//  PickRevisionStyleView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct PickRevisionStyleView: View {
    
    @Binding var navigationState: RevisionNavigationState?
    
    var body: some View {
        NavigationView{
            VStack{
                RevisionStyleView(
                    label: "Review all temps together",
                    image: Image(systemName: "xmark"),
                    action: {
                        navigationState = RevisionNavigationState.review
                    }
                )
                .padding(.bottom, 60)
                
                RevisionStyleView(
                    label: "Review temps 1 by 1",
                    image: Image(systemName: "xmark"),
                    action: {
                        navigationState = RevisionNavigationState.review
                    }
                )
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {
            navigationState = RevisionNavigationState.home
        }))
    }
}

struct PickRevisionStyleView_Previews: PreviewProvider {
    static var previews: some View {
        PickRevisionStyleView(navigationState: .constant(RevisionNavigationState.pickStyle))
    }
}
