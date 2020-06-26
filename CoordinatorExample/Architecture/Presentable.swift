//
//  Presentable.swift
//
//  Created by Chu Anh Minh on 2/25/19.
//

import UIKit

protocol Presentable {
    func toPresentable() -> UIViewController
}

extension UIViewController: Presentable {
    public func toPresentable() -> UIViewController {
        return self
    }
}
