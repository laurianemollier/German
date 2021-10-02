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
    
    //MARK: - DB Alerts
    
    static let invalidURL = AlertItem(title: Text("Sever Error"),
                                      message: Text("There was an issue connecting to the local database. If this persists, please contact support."),
                                      dismissButton: .default(Text("OK")))
    
}
