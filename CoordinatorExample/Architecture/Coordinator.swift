//
//  Coordinator.swift
//
//  Created by Chu Anh Minh on 2/23/19.
//

import UIKit
import Combine

class Coordinator: NSObject {
    enum NavigationType {
        case currentFlow // push
        case newFlow(hideBar: Bool) // present, set root
    }
    
    let router: Router

    private var childCoordinators: [Coordinator] = []
    private let navigationType: NavigationType

    var disposeBag = Set<AnyCancellable>()

    let deeplinkSubject = CurrentValueSubject<String?, Never>(nil)
    var deeplinkDisposeBag = Set<AnyCancellable>()

    let coordinatorStepper = PassthroughSubject<Step, Never>()

    
    var root: Presentable {
        fatalError("Override")
    }
    
    init(router: Router, navigationType: NavigationType) {
        self.router = router
        self.navigationType = navigationType
        
        super.init()

        if case .newFlow(let hideBar) = navigationType {
            router.setRoot(root, hideBar: hideBar)
        }
        
        bindStepper()
    }
    
    func bindStepper() {
        coordinatorStepper.receive(on: DispatchQueue.main)
            .sink { [weak self] step in
                switch step {
                case .popRequired:
                    self?.router.pop()
                case .dismissRequired:
                    self?.router.dismiss()
                case .browserRequired(let urlString):
                    guard let url = URL(string: urlString) else { return }
                    if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
                        UIApplication.shared.open(url, options: [:]) { _ in }
                    }
                case .popToRootRequired:
                    self?.router.popToRoot(animated: true)
                case .dismissChildRequired(coordinator: let coordinator):
                    self?.router.dismiss(coordinator: coordinator)
                case .copyClipboardRequired(text: let text):
                    UIPasteboard.general.string = text
                case .phoneRequired(phone: let phone):
                    let urlString = "telprompt:\(phone)"
                    if let url = URL(string: urlString) {
                        UIApplication.shared.open(url, options: [:]) { _ in }
                    }
                default:
                    break
                }
                
            }.store(in: &disposeBag)
    }

    func resetDeeplink() {
        for child in childCoordinators {
            child.deeplinkDisposeBag = Set<AnyCancellable>()
        }
        deeplinkSubject.send(nil)
    }

    func addChild(_ coordinator: Coordinator) {
        deeplinkSubject
            .subscribe(coordinator.deeplinkSubject)
            .store(in: &coordinator.deeplinkDisposeBag)

        childCoordinators.append(coordinator)
    }

    private func removeChild(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        }
    }

    func setRootChild(coordinator: Coordinator, hideBar: Bool) {
        addChild(coordinator)
        router.setRoot(coordinator, hideBar: hideBar) { [weak self, weak coordinator] in
            guard let coord = coordinator else { return }
            self?.removeChild(coord)
        }
    }

    func pushChild(coordinator: Coordinator, animated: Bool, onRemove: (() -> Void)? = nil) {
        addChild(coordinator)

        router.push(coordinator, animated: animated) { [weak self, weak coordinator] in
            guard let self = self, let coordinator = coordinator else { return }
            onRemove?()
            self.removeChild(coordinator)
        }
    }
    
    // make sure to always call dismissChild after
    func presentChild(coordinator: Coordinator, animated: Bool) {
        addChild(coordinator)
        router.present(coordinator, animated: animated)
    }

    func dismissChild(_ coordinator: Coordinator, animated: Bool) {
        coordinator.toPresentable().presentingViewController?.dismiss(animated: animated, completion: nil)
        removeChild(coordinator)
    }
}

extension Coordinator: Presentable {
    func toPresentable() -> UIViewController {
        switch navigationType {
        case .currentFlow:
            return root.toPresentable()
        case .newFlow:
            return router.toPresentable()
        }
    }
}
