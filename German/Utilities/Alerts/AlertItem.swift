//
//  AlertItem.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}


struct AlertContext {
    static func internalError(_ error: Error) -> AlertItem {
        AlertItem(title: Text("Internal Error"),
                  message: Text("Please contact the support: \(error.localizedDescription)"),
                                          dismissButton: .default(Text("OK")))
    }
}
