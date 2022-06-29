//
//  DataManager.swift
//  WeatherApp
//
//  Created by Вячеслав Кусакин on 20.06.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()

    private init() {}

    func formatDate(unixTime: Int) -> String {
        let formater = DateFormatter()
        formater.dateStyle = .none
        formater.timeStyle = .short
        formater.locale = Locale(identifier: "RU")
        formater.timeZone = .current

        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        return formater.string(from: date)
    }

    enum WidgetTitles: String, CaseIterable {
        case max = "Максимум"
        case min = "Минимум"
        case wind = "Ветер"
        case feels = "Ощущается"
        case humidity = "Влажность"
        case pressure = "Давление"
        case sunrise = "Восход"
        case sunset = "Закат"
    }

    enum WidgetIcons: String, CaseIterable {
        case max = "sun.max.fill" //􀆮
        case min = "sun.min.fill" //􀆬
        case wind = "wind" //􀇤
        case feels = "thermometer" //􀇬
        case humidity = "humidity.fill" //􁃛
        case pressure = "barometer" //􀬧
        case sunrise = "sunrise.fill" //􀆲
        case sunset = "sunset.fill" //􀆴
    }
}
