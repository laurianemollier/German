//
//  Publisher+Ext.swift
//  ComposableArchitecture
//
//  Created by Lauriane Mollier on 11/13/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import Foundation
import Combine

extension Publisher where Failure == Never {
  public func eraseToEffect() -> Effect<Output> {
    return Effect(publisher: self.eraseToAnyPublisher())
  }
}
