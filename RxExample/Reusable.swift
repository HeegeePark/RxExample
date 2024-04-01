//
//  Reusable.swift
//  RxExample
//
//  Created by 박희지 on 4/2/24.
//

import UIKit

protocol Reusable: NSObject {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        return description()
    }
}

extension UIViewController: Reusable {}
