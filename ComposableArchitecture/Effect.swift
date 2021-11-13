//
//  Effect.swift
//  ComposableArchitecture
//
//  Created by Lauriane Mollier on 11/13/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import Foundation
import Combine

public struct Effect<Output>: Publisher {
  public typealias Failure = Never

  let publisher: AnyPublisher<Output, Failure>

  public func receive<S>(
    subscriber: S
  ) where S: Subscriber, Failure == S.Failure, Output == S.Input {
    self.publisher.receive(subscriber: subscriber)
  }
}

extension Effect {
  public static func fireAndForget(work: @escaping () -> Void) -> Effect {
    return Deferred { () -> Empty<Output, Never> in
      work()
      return Empty(completeImmediately: true)
    }.eraseToEffect()
  }
}
