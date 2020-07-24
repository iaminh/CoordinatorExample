//
//  LoginViewController.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/17/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    var onLoginTap: (() -> Void)?
    var onRegisterTap: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Login"
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        onLoginTap?()
    }

    @IBAction func registerButtonTapped(_ sender: Any) {
        onRegisterTap?()
    }
}
