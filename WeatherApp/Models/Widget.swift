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
    static func createWidgets(data: WeatherData) -> [Widget] {
        var widgets: [Widget] = []
        let widget = DataManager.WidgetTitles.max

        switch widget {
        case .max:
            widgets.append(Widget(
                title: DataManager.WidgetTitles.max.rawValue,
                image: DataManager.WidgetIcons.max.rawValue,
                description: String(Int(data.main.tempMax.rounded())) + "°"
            ))
            fallthrough

        case .min:
            widgets.append(Widget(
                title: DataManager.WidgetTitles.min.rawValue,
                image: DataManager.WidgetIcons.min.rawValue,
                description: String(Int(data.main.tempMin.rounded())) + "°"
            ))
            fallthrough

        case .wind:
            widgets.append(Widget(
                title: DataManager.WidgetTitles.wind.rawValue,
                image: DataManager.WidgetIcons.wind.rawValue,
                description: String(data.wind.speed) + "м/с"
            ))
            fallthrough

        case .feels:
            widgets.append(Widget(
                title: DataManager.WidgetTitles.feels.rawValue,
                image: DataManager.WidgetIcons.feels.rawValue,
                description: String(Int(data.main.feelsLike.rounded())) + "°"
            ))
            fallthrough

        case .humidity:
            widgets.append(Widget(
                title: DataManager.WidgetTitles.humidity.rawValue,
                image: DataManager.WidgetIcons.humidity.rawValue,
                description: String(data.main.humidity) + "%"
            ))
            fallthrough

        case .pressure:
            widgets.append(Widget(
                title: DataManager.WidgetTitles.pressure.rawValue,
                image: DataManager.WidgetIcons.pressure.rawValue,
                description: String(Int((Double(data.main.pressure) * 0.750062)
                    .rounded())) + "мм.рт.ст"
            ))
            fallthrough

        case .sunrise:
            widgets.append(Widget(
                title: DataManager.WidgetTitles.sunrise.rawValue,
                image: DataManager.WidgetIcons.sunrise.rawValue,
                description: DataManager.shared.formatDate(unixTime: data.sys.sunrise)
            ))
            fallthrough

        case .sunset:
            widgets.append(Widget(
                title: DataManager.WidgetTitles.sunset.rawValue,
                image: DataManager.WidgetIcons.sunset.rawValue,
                description: DataManager.shared.formatDate(unixTime: data.sys.sunset)
            ))
        }

        return widgets
    }
}

