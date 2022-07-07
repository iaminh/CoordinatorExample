//
//  ViewModel.swift
//  CoordinatorExample
//
//  Created by minh on 07/07/2022.
//  Copyright © 2022 MinhChu. All rights reserved.
//

import Foundation
import Combine

class ViewModel {
    struct ViewLifeCycle {
        let didLoadSubject = PassthroughSubject<Void, Never>()
        let didAppearSubject = PassthroughSubject<Void, Never>()
        let didDisappearSubject = PassthroughSubject<Void, Never>()
        let willAppearSubject = PassthroughSubject<Void, Never>()
        let willDisappearSubject = PassthroughSubject<Void, Never>()
        let willDeinitSubject = PassthroughSubject<Void, Never>()
    }

    enum LoadingState {
        case loading
        case finished
        case failed
    }

    let loadingState = CurrentValueSubject<LoadingState, Never>(.finished)
    var bag = Set<AnyCancellable>()
    let lifeCycle = ViewLifeCycle()
    let stepper = PassthroughSubject<Step, Never>()

    func bindStepper(to stepper: PassthroughSubject<Step, Never>) {
        self.stepper
            .subscribe(stepper)
            .store(in: &bag)
    }
}

class Inputs<Base> {
    public let vm: Base
    public init(_ vm: Base) {
        self.vm = vm
    }
}

class Outputs<Base> {
    let vm: Base
    init(_ vm: Base) {
        self.vm = vm
    }
}

// MARK: Input
protocol InputCompatible {
    associatedtype InputCompatibleType: ViewModel
    var `in`: Inputs<InputCompatibleType> { get }
}

extension ViewModel: InputCompatible {
    typealias InputCompatibleType = ViewModel
}

extension InputCompatible where Self: ViewModel {
    var `in`: Inputs<Self> { return Inputs(self) }
}

// MARK: Output
protocol OutputCompatible {
    associatedtype OutputCompatibleType
    var out: Outputs<OutputCompatibleType> { get }

}
extension OutputCompatible {
    var out: Outputs<Self> { return Outputs(self) }
}

extension ViewModel: OutputCompatible {
    typealias OutputCompatibleType = ViewModel
}
