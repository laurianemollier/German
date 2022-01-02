//
//  RevisionHomeAction.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

enum RevisionHomeAction {
    case loadState
    case optionalRevisionSession(RevisionSessionAction)
    case setRevisionSession(isActive: Bool)
}
