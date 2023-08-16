//
//  ActivityIndicator.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

import UIKit

final class BlockingActivityIndicator: UIView {
    
    private let activityIndicator: UIActivityIndicatorView
    
    override init(frame: CGRect) {
        self.activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.tintColor = .darkGray
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.35)
        addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIWindow {
    
    func startBlockingActivityIndicator() {
        guard !subviews.contains(where: { $0 is BlockingActivityIndicator }) else {
            return
        }
        
        let activityIndicator = BlockingActivityIndicator()
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicator.frame = bounds
        
        UIView.transition(
            with: self,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: {
                self.addSubview(activityIndicator)
            }
        )
    }
    
    func stopBlockingActivityIndicator() {
        subviews.filter({ $0 is BlockingActivityIndicator }).forEach({ $0.removeFromSuperview() })
    }
}
