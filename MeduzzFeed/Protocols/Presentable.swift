//
//  Presentable.swift
//  MeduzzFeed
//
//  Created by Denis Sheikherev on 01.03.2021.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {

    func toPresent() -> UIViewController? {
        return self
    }
}
