//
//  BaseViewController.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

import UIKit

class BaseViewController<V: BaseViewModelProtocol>: UIViewController, BaseViewController.LoadingProtocols {
    
    typealias LoadingProtocols = LoadingProtocol & ActivityIndicatorProtocol
    
    private let tryAgainButton = UIButtonBuilder()
        .titleColor(.white)
        .titleFont(UIFont(name: "Nunito-Bold", size: 16))
        .build()
    
    var viewModel: V
    
    init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        subscribeShowTryAgainButton()
        subscribeHideTryAgainButton()
        subscribeActivityIndicatorView()
        subscribeLoading()
        subscribeToast()
    }
    
// MARK: - Actions
    @objc
    private func tryAgainButtonTapped() {
        viewModel.tryAgainButtonTapped()
    }
}

extension BaseViewController {
    
    func addTryAgainButton() {
        view.addSubview(tryAgainButton)
        tryAgainButton.centerInSuperview()
        tryAgainButton.backgroundColor = .red
        tryAgainButton.size(.init(width: 200, height: 50))
        tryAgainButton.setTitle("L10n.Base.errorButtonTitle", for: .normal)
        tryAgainButton.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
    }
    
    func subscribeShowTryAgainButton() {
        viewModel.showTryAgainButton = { [weak self] in
            self?.addTryAgainButton()
        }
    }
    
    func subscribeHideTryAgainButton() {
        viewModel.hideTryAgainButton = { [weak self] in
            self?.tryAgainButton.removeFromSuperview()
        }
    }
    
    func subscribeActivityIndicatorView() {
        viewModel.hideActivityIndicatorView = { [weak self] in
            self?.hideActivityIndicator()
        }
        viewModel.showActivityIndicatorView = { [weak self] in
            self?.showActivityIndicator()
        }
    }
    
    func subscribeLoading() {
        viewModel.hideLoading = { [weak self] in
            DispatchQueue.main.async {
                self?.dismissLoading()
            }
        }
        viewModel.showLoading = { [weak self] in
            DispatchQueue.main.async {
                self?.presentLoading()
            }
        }
    }
    
    func subscribeToast() {
        viewModel.showWarningToast = { message in
            ToastPresenter.showWarningToast(text: message)
        }
        
        viewModel.showSuccessToast = { message in
            ToastPresenter.showSuccessToast(text: message)
        }
    }
}
