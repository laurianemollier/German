//
//  Logging.swift
//  ComposableArchitecture
//
//  Created by Lauriane Mollier on 11/13/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import Foundation
import Combine

public func logging<Value, Action>(
  _ reducer: @escaping Reducer<Value, Action>
) -> Reducer<Value, Action> {
  return { value, action in
    let effects = reducer(&value, action)
    let newValue = value
    return [.fireAndForget {
      print("Action: \(action)")
      print("Value:")
      dump(newValue)
      print("---")
      }] + effects
  }
}
