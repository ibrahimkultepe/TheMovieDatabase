//
//  ActivityIndicatorView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

import UIKit

public class ActivityIndicatorView: UIActivityIndicatorView {
    
   public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        style = .gray
        tintColor = .darkGray
        hidesWhenStopped = true
    }
}
