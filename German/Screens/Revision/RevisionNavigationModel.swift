//
//  RevisionNavigationModel.swift
//  German
//
//  Created by Lauriane Mollier on 12/4/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

final class RevisionNavigationModel: ObservableObject {
    @Published var activeRevision: Bool = false {
        didSet {
            print("activeRevision: ", String(describing: self.activeRevision))
        }
    }
}
