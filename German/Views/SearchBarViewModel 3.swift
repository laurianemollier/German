//
//  SearchBarModel.swift
//  German
//
//  Created by Lauriane Mollier on 10/10/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

final class SearchBarViewModel: ObservableObject {

    @Published var searchText: String = "" {
        didSet {
            if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                isSearching = false
            } else {
                isSearching = true
            }
        }
    }
    @Published var isSearching: Bool = false
    
}
