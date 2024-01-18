//
//  UIViewController+loading.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {

    func startLoading(message: String? = nil) {
        NVActivityIndicatorView.DEFAULT_COLOR = .appMainColor
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = .black.withAlphaComponent(0.4)
        NVActivityIndicatorView.DEFAULT_TEXT_COLOR = .black
        NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT = .systemFont(ofSize: 16)
        startAnimating(message: message, type: NVActivityIndicatorType.ballScaleMultiple)
    }

    func setLoadingMessage(message: String) {
        NVActivityIndicatorPresenter.sharedInstance.setMessage(message)
    }

    func stopLoading() {
        stopAnimating()
    }

}
