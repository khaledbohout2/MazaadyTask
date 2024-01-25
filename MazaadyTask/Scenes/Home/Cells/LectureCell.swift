//
//  LectureCell.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 25/01/2024.
//

import UIKit

class LectureCell: UICollectionViewCell {
    lazy var containerView: UIView = {
        let view = UIView()
        view.makeRoundedCorner(cornerRadius: 24)
        return view
    }()

    lazy var lectureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Base Background")
        imageView.makeRoundedCorner(cornerRadius: 15)
        return imageView
    }()

    lazy var lectureNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Step design sprint for beginner"
        label.textColor = .white
        label.font = .poppins(.semiBold, size: 18)
        label.numberOfLines = 2
        return label
    }()

    lazy var lectureDurationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stopwatch")
        return imageView
    }()

    lazy var lectureDurationLabel: UILabel = {
        let label = UILabel()
        label.text = "Lecture Duration"
        label.textColor = .white
        label.font = .poppins(.regular, size: 14)
        return label
    }()

    lazy var numberOfLessonsLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Lessons"
        label.textColor = .white
        label.font = .poppins(.regular, size: 14)
        label.backgroundColor = .appPictonBlue
        label.makeRoundedCorner(cornerRadius: 4)
        return label
    }()

    lazy var courseSubjectLbl: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Subject"
        label.textColor = .white
        label.font = .poppins(.regular, size: 14)
        label.backgroundColor = .appYellowColor
        label.makeRoundedCorner(cornerRadius: 4)
        return label
    }()

    lazy var coursePriceLbl: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Price"
        label.textColor = .white
        label.backgroundColor = .appRed
        label.font = .poppins(.regular, size: 14)
        label.makeRoundedCorner(cornerRadius: 4)
        return label
    }()

    lazy var lecturerProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Avatar")
        imageView.makeRoundedCorner(cornerRadius: 20)
        return imageView
    }()

    lazy var lecturerNameLbl: UILabel = {
        let label = UILabel()
        label.text = "Lecturer Name"
        label.textColor = .white
        label.font = .poppins(.semiBold, size: 14)
        return label
    }()

    lazy var lecturerJobLbl: UILabel = {
        let label = UILabel()
        label.text = "Lecturer Job"
        label.textColor = .white
        label.font = .poppins(.regular, size: 12)
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
        containerView.fillSuperview()

        containerView.addSubview(lectureImageView)
        lectureImageView.fillSuperview()

        containerView.addSubview(lecturerProfileImageView)
        lecturerProfileImageView.anchor(.leading(containerView.leadingAnchor, constant: 20),
                                        .bottom(containerView.bottomAnchor, constant: 30),
                                        .width(40),
                                        .height(40))

        containerView.addSubview(lecturerNameLbl)
        lecturerNameLbl.anchor(.leading(lecturerProfileImageView.trailingAnchor, constant: 10),
                               .top(lecturerProfileImageView.topAnchor, constant: 0))

        containerView.addSubview(lecturerJobLbl)
        lecturerJobLbl.anchor(.leading(lecturerProfileImageView.trailingAnchor, constant: 10),
                              .top(lecturerNameLbl.bottomAnchor, constant: 5))

        containerView.addSubview(numberOfLessonsLabel)
        numberOfLessonsLabel.anchor(.leading(containerView.leadingAnchor, constant: 15),
                                    .bottom(lecturerProfileImageView.topAnchor, constant: 10))

        containerView.addSubview(courseSubjectLbl)
        courseSubjectLbl.anchor(.leading(numberOfLessonsLabel.trailingAnchor, constant: 15),
                                .bottom(lecturerProfileImageView.topAnchor, constant: 10))

        containerView.addSubview(coursePriceLbl)
        coursePriceLbl.anchor(.leading(courseSubjectLbl.trailingAnchor, constant: 10),
                              .bottom(lecturerProfileImageView.topAnchor, constant: 10))

        containerView.addSubview(lectureDurationIcon)
        lectureDurationIcon.anchor(.leading(containerView.leadingAnchor, constant: 20),
                                   .bottom(numberOfLessonsLabel.topAnchor, constant: 20))

        containerView.addSubview(lectureDurationLabel)
        lectureDurationLabel.anchor(.leading(lectureDurationIcon.trailingAnchor, constant: 5),
                                    .bottom(numberOfLessonsLabel.topAnchor, constant: 20))

        containerView.addSubview(lectureNameLabel)
        lectureNameLabel.anchor(.leading(containerView.leadingAnchor, constant: 20),
                                .bottom(lectureDurationIcon.topAnchor, constant: 10),
                                .trailing(containerView.trailingAnchor, constant: 40))
    }
}
