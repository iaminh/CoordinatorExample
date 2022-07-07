//
//  Controller.swift
//  CoordinatorExample
//
//  Created by minh on 07/07/2022.
//  Copyright © 2022 MinhChu. All rights reserved.
//

import Foundation
import UIKit

class Controller<VM: ViewModel>: UIViewController {
    public let vm: VM

    init(viewModel: VM) {
        self.vm = viewModel
        super.init(nibName: NSStringFromClass(type(of: self)).components(separatedBy: ".").last, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {

        vm.lifeCycle.didLoadSubject.send()

        super.viewDidLoad()

        bindToVM()
    }

    deinit {
        vm.lifeCycle.willDeinitSubject.send()
    }

    override func viewWillAppear(_ animated: Bool) {
        vm.lifeCycle.willAppearSubject.send()
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        vm.lifeCycle.didAppearSubject.send()
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        vm.lifeCycle.willDisappearSubject.send()
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        vm.lifeCycle.didDisappearSubject.send()
        super.viewDidDisappear(animated)
    }

    func bindToVM() { }
}
