//
//  UIButton+addTarget.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import UIKit

extension UIButton {
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    private struct AssociatedObjectKeyss {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }

    private typealias Action = (() -> Void)?

    // Set our computed property type to a closure
    private var tapAction: Action? {
        get {
            let tapGestureRecognizerActionInstance =
            objc_getAssociatedObject(self, &AssociatedObjectKeyss.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self,
                                         &AssociatedObjectKeyss.tapGestureRecognizer,
                                         newValue,
                                         objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
    }

    func addTarget(action: (() -> Void)?) {
        tapAction = action
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            addTarget(self, action: #selector(handleTapTarget), for: .touchUpInside)
        }
    }

    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc private func handleTapTarget(sender: UIButton) {
        if let action = self.tapAction {
            action?()
        } else {
            print("no action")
        }
    }
}
