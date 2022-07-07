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

    func configureCell(with widget: Widget) {
        titleImage.image = UIImage(systemName: widget.image ?? "")
        titleLabel.text = widget.title
        descriptionLabel.text = widget.description

        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
    }
}



