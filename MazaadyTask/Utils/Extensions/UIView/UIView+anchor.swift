//
//  UIView+anchor.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import UIKit

public struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height, centerX, centerY: NSLayoutConstraint?
}

public enum Anchor {
    case top(_ top: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case leading(_ leading: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case bottom(_ bottom: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case trailing(_ trailing: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case centerX(_ centerX: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case centerY(_ centerY: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case height(_ constant: CGFloat)
    case width(_ constant: CGFloat)
}

extension UIView {

    @discardableResult
    func anchor(_ anchors: Anchor...) -> AnchoredConstraints {

        translatesAutoresizingMaskIntoConstraints = false

        var anchoredConstraints = AnchoredConstraints()

        anchors.forEach { anchor in
            switch anchor {
            case .top(let anchor, let constant):
                anchoredConstraints.top = topAnchor.constraint(equalTo: anchor, constant: constant)
            case .leading(let anchor, let constant):
                anchoredConstraints.leading = leadingAnchor.constraint(equalTo: anchor, constant: constant)
            case .bottom(let anchor, let constant):
                anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: anchor, constant: -constant)
            case .trailing(let anchor, let constant):
                anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: anchor, constant: -constant)
            case .centerX(let anchor, let constant):
                anchoredConstraints.centerX = centerXAnchor.constraint(equalTo: anchor, constant: constant)
            case .centerY(let anchor, let constant):
                anchoredConstraints.centerY = centerYAnchor.constraint(equalTo: anchor, constant: constant)
            case .height(let constant):
                if constant >= 0 {
                    anchoredConstraints.height = heightAnchor.constraint(equalToConstant: constant)
                }
            case .width(let constant):
                if constant >= 0 {
                    anchoredConstraints.width = widthAnchor.constraint(equalToConstant: constant)
                }
            }
        }

        [anchoredConstraints.top,
         anchoredConstraints.leading,
         anchoredConstraints.bottom,
         anchoredConstraints.trailing,
         anchoredConstraints.centerX,
         anchoredConstraints.centerY,
         anchoredConstraints.width,
         anchoredConstraints.height
        ].forEach {
            $0?.isActive = true
        }

        return anchoredConstraints
    }
}
