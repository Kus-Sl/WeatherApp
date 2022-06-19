//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Вячеслав Кусакин on 18.06.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var widgetsCollection: UICollectionView!

    private let items: CGFloat = 2
    private let spacing: CGFloat = 10

    

    override func viewDidLoad() {
        super.viewDidLoad()

        widgetsCollection.delegate = self
        widgetsCollection.dataSource = self
    }
}


// температура макс
// температура мин
// ощущается как
// ветер
// давление
// влажность
// закат
// восход



// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = widgetsCollection.dequeueReusableCell(withReuseIdentifier: WidgetCollectionViewCell.identifier, for: indexPath) as! WidgetCollectionViewCell



        cell.backgroundColor = .red
        cell.layer.cornerRadius = 20

        return cell
    }
}

//     MARK: UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let availableWidth = collectionView.frame.width - (items + 1) * spacing
        let itemSize = availableWidth / items

        return CGSize(width: itemSize, height: itemSize / 1.5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
    }
}
