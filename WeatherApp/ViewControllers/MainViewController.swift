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

    @IBOutlet weak var imageDescription: UIImageView!

    private let items: CGFloat = 2
    private let spacing: CGFloat = 10

    private var widgets: [Widget] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        widgetsCollection.delegate = self
        widgetsCollection.dataSource = self

        setData()
    }
}

// MARK: Fetching data
extension MainViewController {
    private func setData() {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let weatherData):
                widgets = Widget.createWidgets(data: weatherData)
                currentTempLabel.text = String(Int(weatherData.main.temp.rounded())) + "°"
                descriptionLabel.text = weatherData.weather.first?.description
                print(widgets)
            case .failure(let error):
                print(error)
            }
        }

        NetworkManager.shared.fetchImage { result in
            switch result {
            case .success(let image):
                imageDescription.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        widgets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = widgetsCollection.dequeueReusableCell(withReuseIdentifier: WidgetCollectionViewCell.identifier, for: indexPath) as! WidgetCollectionViewCell

        cell.config(widget: widgets[indexPath.item])

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
