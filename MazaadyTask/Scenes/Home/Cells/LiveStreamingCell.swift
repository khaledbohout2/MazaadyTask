//
//  LiveStreamingCell.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 25/01/2024.
//

import Foundation
import UIKit

class LiveStreamingCell: UICollectionViewCell {

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.makeRoundedCorner(cornerRadius: 24, borderColor: .appRed, borderWidth: 1)
        return view
    }()

    lazy var liveImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Avatar 1")
        imageView.makeRoundedCorner(cornerRadius: 24)
        return imageView
    }()

    lazy var videoIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Live Circle")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isOpaque = false
        setupLayOut()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayOut() {
        contentView.addSubview(containerView)
        containerView.anchor(.leading(contentView.leadingAnchor, constant: 8),
                             .trailing(contentView.trailingAnchor, constant: 8),
                             .top(contentView.topAnchor, constant: 0),
                             .bottom(contentView.bottomAnchor, constant: 0))

        containerView.addSubview(liveImageView)
        liveImageView.anchor(.leading(containerView.leadingAnchor, constant: 0),
                             .top(containerView.topAnchor, constant: 0),
                             .width(65),
                             .height(65))

        contentView.addSubview(videoIcon)
        videoIcon.anchor(.trailing(contentView.trailingAnchor, constant: 0),
                         .bottom(contentView.bottomAnchor, constant: 0),
                         .width(20),
                         .height(20))
    }

}
