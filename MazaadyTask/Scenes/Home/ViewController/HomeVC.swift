//
//  HomeVC.swift
//  MazaadyTask
//
//  Created by Khaled Bohout on 25/01/2024.
//

import UIKit

class HomeVC: BaseVC<HomeView>, BaseViewProtocol {

    private var coursesNames = ["All", "UI/UX", "Illustration", "3D Animation"]

    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.image = UIImage(named: "menu")
        tabBarItem.title = ""
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        mainView.setDelegate(self)
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.coursesCV {
            return coursesNames.count
        } else if collectionView == mainView.liveStreamingCV {
            return 4
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.coursesCV {
            let cell = collectionView.forceDequeueCell(identifier: CourseCell.identifier, for: indexPath) as CourseCell
            cell.courseNameLabel.text = coursesNames[indexPath.row]
            return cell
        } else if collectionView == mainView.liveStreamingCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveStreamingCell", for: indexPath) as! LiveStreamingCell
            return cell
        } else {
            let cell = collectionView.forceDequeueCell(identifier: LectureCell.identifier, for: indexPath) as LectureCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            if collectionView == mainView.coursesCV {
                let width = coursesNames[indexPath.row].widthOfString(usingFont: .poppins(.medium, size: 14)) + 30
                return CGSize(width: width, height: 40)
            } else if collectionView == mainView.liveStreamingCV {
                return CGSize(width: 80, height: 65)
            } else {
                return CGSize(width: 316, height: 360)
            }
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        return ceil(size.width)
    }
}
