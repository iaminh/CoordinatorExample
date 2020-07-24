//
//  Combine+Extensions.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/24/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import Foundation
import Combine

public protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    public var value: Wrapped? {
        return self
    }
}

extension Publishers {
    struct Unwrapped<Upstream> : Publisher where Upstream: Publisher, Upstream.Output: OptionalType {

        public typealias Output = Upstream.Output.Wrapped
        public typealias Failure = Upstream.Failure

        /// The publisher from which this publisher receives elements.
        public let upstream: AnyPublisher<Upstream.Output.Wrapped, Upstream.Failure>

        public init(upstream: Upstream) {
            self.upstream = upstream
                .flatMap { optional -> AnyPublisher<Output, Failure> in
                    guard let unwrapped = optional.value else {
                        return Empty().eraseToAnyPublisher()
                    }
                    return Result.Publisher(unwrapped).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        }

        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            upstream.receive(subscriber: subscriber)
        }
    }
}

extension Publisher where Output: OptionalType {
    func unwrap() -> Publishers.Unwrapped<Self> {
        return Publishers.Unwrapped(upstream: self)
    }
}
