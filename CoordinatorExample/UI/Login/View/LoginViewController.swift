//
//  LoginViewController.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/17/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import UIKit
import Combine

class LoginViewController: Controller<LoginViewModel> {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    let stepper = PassthroughSubject<Step, Never>()


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Login"
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        vm.in.loginTap.send()
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        vm.in.registerTap.send()
    }
}
