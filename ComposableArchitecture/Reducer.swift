//
//  Reducer.swift
//  ComposableArchitecture
//
//  Created by Lauriane Mollier on 11/13/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import Foundation

public typealias Reducer<Value, Action> = (inout Value, Action) -> [Effect<Action>]

public func combine<Value, Action>(
  _ reducers: Reducer<Value, Action>...
) -> Reducer<Value, Action> {
  return { value, action in
    let effects = reducers.flatMap { $0(&value, action) }
    return effects
  }
}

public func pullback<LocalValue, GlobalValue, LocalAction, GlobalAction>(
  _ reducer: @escaping Reducer<LocalValue, LocalAction>,
  value: WritableKeyPath<GlobalValue, LocalValue>,
  action: WritableKeyPath<GlobalAction, LocalAction?>
) -> Reducer<GlobalValue, GlobalAction> {
  return { globalValue, globalAction in
    guard let localAction = globalAction[keyPath: action] else { return [] }
    let localEffects = reducer(&globalValue[keyPath: value], localAction)

    return localEffects.map { localEffect in
      localEffect.map { localAction -> GlobalAction in
        var globalAction = globalAction
        globalAction[keyPath: action] = localAction
        return globalAction
      }
      .eraseToEffect()
    }
  }
}
