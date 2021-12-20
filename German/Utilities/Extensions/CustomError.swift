//
//  CustomError.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 8/15/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import Foundation

// TOOD: read https://www.advancedswift.com/custom-errors-in-swift/
enum CustomError: Error {
    case VerbNotFound
    case IllegalState
    case ReviewListEmpty
    case AudioFileNotFound(fileName: String)
}
