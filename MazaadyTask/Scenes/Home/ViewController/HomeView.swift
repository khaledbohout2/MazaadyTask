//
//  HomeView.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 25/01/2024.
//

import UIKit

class HomeView: BaseView {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    lazy var navContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AvatarHeader")
        imageView.makeRoundedCorner(cornerRadius: 25)
        return imageView
    }()

    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, Khaled Bohout"
        label.font = .poppins(.bold, size: 15)
        label.textColor = .black
        return label
    }()

    lazy var userPointsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "award")
        return imageView
    }()

    lazy var pointsLbl: UILabel = {
        let label = UILabel()
        label.text = "+1600 Points"
        label.font = .poppins(.regular, size: 12)
        label.textColor = .appYellowColor
        return label
    }()

    lazy var notificationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "notifications")
        return imageView
    }()

    lazy var liveStreamingCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(LiveStreamingCell.self,
                                forCellWithReuseIdentifier: LiveStreamingCell.identifier)
        return collectionView
    }()

    lazy var upcomingLbl: UILabel = {
        let label = UILabel()
        label.text = "Upcoming"
        label.font = .poppins(.bold, size: 15)
        label.textColor = .black
        return label
    }()

    lazy var courseOfThisWeekLbl: UILabel = {
        let label = UILabel()
        label.text = "Course of this week"
        label.font = .poppins(.regular, size: 15)
        label.textColor = .black
        return label
    }()

    lazy var coursesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CourseCell.self,
                                forCellWithReuseIdentifier: CourseCell.identifier)
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()

    lazy var lecturesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(LectureCell.self,
                                forCellWithReuseIdentifier: LectureCell.identifier)
        return collectionView
    }()

    override func setupView() {
        super.setupView()
        addScrollView()
        addNavContainerView()
        addLiveStreamingCV()
        addUpcomingCoursesCV()
        addLecturesCV()
    }

    func addScrollView() {
        addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(contentView)
        contentView.fillSuperview()
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        heightConstraint.isActive = true
    }

    func addNavContainerView() {
        contentView.addSubview(navContainerView)
        navContainerView.anchor(
            .top(contentView.topAnchor, constant: 0),
            .leading(contentView.leadingAnchor),
            .trailing(contentView.trailingAnchor),
            .height(80))

        navContainerView.addSubview(profileImageView)
        profileImageView.anchor(
            .top(navContainerView.topAnchor, constant: 20),
            .leading(navContainerView.leadingAnchor, constant: 20),
            .width(50),
            .height(50))

        navContainerView.addSubview(userNameLabel)
        userNameLabel.anchor(
            .top(navContainerView.topAnchor, constant: 20),
            .leading(profileImageView.trailingAnchor, constant: 10))

        navContainerView.addSubview(userPointsIcon)
        userPointsIcon.anchor(
            .top(userNameLabel.bottomAnchor, constant: 10),
            .leading(profileImageView.trailingAnchor, constant: 10),
            .width(15),
            .height(15))

        navContainerView.addSubview(pointsLbl)
        pointsLbl.anchor(
            .top(userNameLabel.bottomAnchor, constant: 10),
            .leading(userPointsIcon.trailingAnchor, constant: 5))

        navContainerView.addSubview(notificationIcon)
        notificationIcon.anchor(
            .top(navContainerView.topAnchor, constant: 20),
            .trailing(navContainerView.trailingAnchor, constant: 20),
            .width(25),
            .height(25))
    }

    func addLiveStreamingCV() {
        contentView.addSubview(liveStreamingCV)
        liveStreamingCV.anchor(
            .top(navContainerView.bottomAnchor, constant: 10),
            .leading(contentView.leadingAnchor, constant: 0),
            .trailing(contentView.trailingAnchor, constant: 0),
            .height(85))
    }

    func addUpcomingCoursesCV() {
        contentView.addSubview(upcomingLbl)
        upcomingLbl.anchor(.top(liveStreamingCV.bottomAnchor, constant: 20),
                           .leading(contentView.leadingAnchor, constant: 20))

        contentView.addSubview(courseOfThisWeekLbl)
        courseOfThisWeekLbl.anchor(.top(liveStreamingCV.bottomAnchor, constant: 20),
                                   .leading(upcomingLbl.trailingAnchor, constant: 3))

        contentView.addSubview(coursesCV)
        coursesCV.anchor(.top(upcomingLbl.bottomAnchor, constant: 15),
                         .leading(contentView.leadingAnchor, constant: 10),
                         .trailing(contentView.trailingAnchor, constant: 0),
                         .height(50))
    }

    func addLecturesCV() {
        contentView.addSubview(lecturesCV)
        lecturesCV.anchor(.top(coursesCV.bottomAnchor, constant: 5),
                          .leading(contentView.leadingAnchor, constant: 0),
                          .trailing(contentView.trailingAnchor, constant: 0),
                          .height(360))
    }

    func setDelegate(_ delegate: Any) {
        liveStreamingCV.delegate = delegate as? UICollectionViewDelegate
        liveStreamingCV.dataSource = delegate as? UICollectionViewDataSource
        coursesCV.delegate = delegate as? UICollectionViewDelegate
        coursesCV.dataSource = delegate as? UICollectionViewDataSource
        lecturesCV.delegate = delegate as? UICollectionViewDelegate
        lecturesCV.dataSource = delegate as? UICollectionViewDataSource
    }

}
