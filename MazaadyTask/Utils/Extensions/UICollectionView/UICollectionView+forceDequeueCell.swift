//
//  UICollectionView+forceDequeueCell.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 25/01/2024.
//

import UIKit

extension UICollectionView {
    func forceDequeueCell<T: UICollectionViewCell>(identifier: String, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
