//
//  WidgetCollectionViewCell.swift
//  WeatherApp
//
//  Created by Вячеслав Кусакин on 18.06.2022.
//

import UIKit

class WidgetCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    static let identifier = "Widget"



    func setupWidgetCell(title: String, image: UIImage, description: String) {
        titleLabel.text = title
        titleImage.image = image
        descriptionLabel.text = description
    }

}



