//
//  ActivityIndicatorViewFooterView.swift
//  UIComponents
//
//  Created by İbrahim Kültepe on 24.08.2023.
//

import UIKit

public class ActivityIndicatorViewFooterView: UICollectionReusableView, ReusableView {
    
    private let activityIndicatorView = ActivityIndicatorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UILayout
extension ActivityIndicatorViewFooterView {
    
    private func addSubviews() {
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
    }
}

// MARK: - Actions
public extension ActivityIndicatorViewFooterView {
    
    func startLoading() {
        activityIndicatorView.startAnimating()
    }
    
    func stopLoading() {
        activityIndicatorView.stopAnimating()
    }
}
