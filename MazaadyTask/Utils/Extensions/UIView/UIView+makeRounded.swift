//
//  UIView+makeRounded.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 18/01/2024.
//

import UIKit

extension UIView {

    func makeRoundedCorner(cornerRadius: CGFloat,
                           borderColor: UIColor = UIColor.clear,
                           borderWidth: CGFloat = 1,
                           cornerMask: CACornerMask = [.layerMaxXMaxYCorner,
                                                       .layerMaxXMinYCorner,
                                                       .layerMinXMaxYCorner,
                                                       .layerMinXMinYCorner]) {
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = cornerMask
        self.clipsToBounds = true
    }
}
