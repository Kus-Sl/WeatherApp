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

    enum WidgetTitles: String {
        case max = "Максимум"
        case min = "Минимум"
        case wind = "Ветер"
        case feels = "Ощущается"
        case humidity = "Влажность"
        case pressure = "Давление"
        case sunrise = "Восход"
        case sunset = "Закат"
    }

    enum WidgetIcons: String {
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





