//
//  ReusableView+Extensions.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 17.08.2023.
//

import UIKit

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
