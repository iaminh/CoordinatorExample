//
//  Coordinator.swift
//
//  Created by Chu Anh Minh on 2/23/19.
//

import UIKit

class Coordinator: NSObject {
    enum NavigationType {
        case currentFlow
        case newFlow
    }
    
    let router: Router
    private var childCoordinators: [Coordinator] = []
    private let navigationType: NavigationType
    
    var root: Presentable {
        fatalError("Override")
    }
    
    init(router: Router, navigationType: NavigationType) {
        self.router = router
        self.navigationType = navigationType
        
        super.init()

        switch navigationType {
        case .currentFlow:
            router.push(root)
        case .newFlow:
            router.setRoot(root)
        }
    }
    
    private func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    private func removeChild(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
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
