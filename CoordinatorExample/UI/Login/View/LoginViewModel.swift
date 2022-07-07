//
//  LoginViewModel.swift
//  CoordinatorExample
//
//  Created by minh on 07/07/2022.
//  Copyright © 2022 MinhChu. All rights reserved.
//

import Foundation
import Combine

class LoginViewModel: ViewModel {
    fileprivate var loginSubject = PassthroughSubject<Void, Never>()
    fileprivate var registrationSubjectSubject = PassthroughSubject<Void, Never>()
    
    override init() {
        super.init()
        bindRx()
    }
    
    private func bindRx() {
        loginSubject
            .sink { [weak self] _ in
                self?.stepper.send(.homeRequired)
            }
            .store(in: &bag)
        
        registrationSubjectSubject
            .sink { [weak self] _ in
                self?.stepper.send(.registerRequired)
            }.store(in: &bag)
    }
}


extension Outputs where Base == LoginViewModel {
    var title: String { return "Login" }
}

extension Inputs where Base == LoginViewModel {
    var loginTap: PassthroughSubject<Void, Never> { vm.loginSubject }
    var registerTap: PassthroughSubject<Void, Never> { vm.registrationSubjectSubject }
}
