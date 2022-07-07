//
//  LoginCoordinator.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/17/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import Foundation
import Combine

class LoginCoordinator: Coordinator {
    private lazy var loginVC: LoginViewController = {
        let vm = LoginViewModel()
        let vc = LoginViewController(viewModel: vm)
        
        vm.bindStepper(to: coordinatorStepper) // important -- use for binding

        return vc
    }()

    private func showRegistration() {
        router.push(RegistrationViewController())
    }
    
    override var root: Presentable {
        return loginVC
    }
    
    override func bindStepper() {
        super.bindStepper()
        
        coordinatorStepper.receive(on: DispatchQueue.main)
            .sink { [weak self] step in
                switch step {
                case .homeRequired: // cai nay thang parent (AppCoordinator) no da observe roi
                    break
                case .registerRequired:
                    self?.showRegistration()
                default:
                    break
                }
                
            }.store(in: &disposeBag)
        
    }
}
