//
//  Widget.swift
//  WeatherApp
//
//  Created by Вячеслав Кусакин on 19.06.2022.
//

import Foundation

struct Widget {
    let title: String?
    let image: String?
    let description: String?
}

extension Widget {
    static func createWidgets(with data: WeatherData) -> [Widget] {
        var widgets: [Widget] = []

        let titles = DataManager.WidgetTitles.allCases.map { $0.rawValue }
        let icons = DataManager.WidgetIcons.allCases.map { $0.rawValue }
        var description: String

        for (index, title) in titles.enumerated() {
            guard let test = DataManager.WidgetTitles.init(rawValue: title)
            else { return widgets }

            switch test {
            case .max:
                description = String(Int(data.main.tempMax.rounded())) + "°"
            case .min:
                description = String(Int(data.main.tempMin.rounded())) + "°"
            case .wind:
                description = String(data.wind.speed) + "м/с"
            case .feels:
                description = String(Int(data.main.feelsLike.rounded())) + "°"
            case .humidity:
                description = String(data.main.humidity) + "%"
            case .pressure:
                description = String(Int((Double(data.main.pressure) * 0.750062).rounded())) + "мм.рт.ст"
            case .sunrise:
                description = DataManager.shared.formatDateToStandard(from: data.sys.sunrise)
            case .sunset:
                description = DataManager.shared.formatDateToStandard(from: data.sys.sunset)
            }

            widgets.append(Widget(
                title: title,
                image: icons[index],
                description: description
            ))
        }

        return widgets
    }
}

