//
//  CourseCell.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 25/01/2024.
//

import UIKit

class CourseCell: UICollectionViewCell {
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.makeRoundedCorner(cornerRadius: 8)
        view.backgroundColor = .appGray
        return view
    }()

    lazy var courseNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Course Name"
        label.textColor = .appDarkGray
        label.font = .poppins(.medium, size: 14)
        return label
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
        containerView.anchor(.leading(contentView.leadingAnchor, constant: 5),
                              .trailing(contentView.trailingAnchor, constant: 5),
                              .top(contentView.topAnchor, constant: 5),
                              .bottom(contentView.bottomAnchor, constant: 5))

        containerView.addSubview(courseNameLabel)
        courseNameLabel.anchor(.leading(containerView.leadingAnchor, constant: 10),
                               .trailing(containerView.trailingAnchor, constant: 10),
                               .centerY(containerView.centerYAnchor))
    }

}
