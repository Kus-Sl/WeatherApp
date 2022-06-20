//
//  JSONModels.swift
//  WeatherApp
//
//  Created by Вячеслав Кусакин on 19.06.2022.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: MainData
    let wind: Wind
    let sys: SunTime
}

struct Weather: Decodable {
    let description: String
    let icon: String
}

struct MainData: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Decodable {
    let speed: Double
}

struct SunTime: Decodable {
    let sunrise: Int
    let sunset: Int
    let country: String
}

