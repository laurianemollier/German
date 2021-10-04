//
//  RevisionNavigation.swift
//  German
//
//  Created by Lauriane Mollier on 10/4/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

final class RevisionNavigation: ObservableObject {
    @Published var state: RevisionNavigationState
    
    init(state: RevisionNavigationState) {
        self.state = state
    }
}
