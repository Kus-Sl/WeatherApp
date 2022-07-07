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

    init(data: [String: Any]) {
        let weatherDicts = data["weather"] as? [[String: Any]] ?? []
        weather = weatherDicts.map({ Weather(data: $0) })

        let mainDict = data["main"] as? [String: Any] ?? [:]
        main = MainData(data: mainDict)

        let windDict = data["wind"] as? [String: Double] ?? [:]
        wind = Wind(data: windDict)

        let sysDict = data["sys"] as? [String: Any] ?? [:]
        sys = SunTime(data: sysDict)
    }

    static func getWeatherData(from json: Any) -> WeatherData? {
        guard let jsonData = json as? [String: Any] else { return nil }
        return WeatherData(data: jsonData)
    }
}

struct Weather: Decodable {
    let description: String
    let icon: String

    init(data: [String: Any]) {
        description = data["description"] as? String ?? ""
        icon = data["icon"] as? String ?? ""
    }
}

struct MainData: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int

    init(data: [String: Any]) {
        temp = data["temp"] as? Double ?? 0
        feelsLike = data["feels_like"] as? Double ?? 0
        tempMin = data["temp_min"] as? Double ?? 0
        tempMax = data["temp_max"] as? Double ?? 0
        pressure = data["pressure"] as? Int ?? 0
        humidity = data["humidity"] as? Int ?? 0
    }
}

struct Wind: Decodable {
    let speed: Double

    init(data: [String: Double]) {
        speed = data["speed"] ?? 0
    }
}

struct SunTime: Decodable {
    let sunrise: Int
    let sunset: Int
    let country: String

    init(data: [String: Any]) {
        sunrise = data["sunrise"] as? Int ?? 0
        sunset = data["sunset"] as? Int ?? 0
        country = data["country"] as? String ?? ""
    }
}


let json = """
{
    "coord": {
        "lon": 37.6156,
        "lat": 55.7522
    },
    "weather": [
        {
            "id": 804,
            "main": "Clouds",
            "description": "пасмурно",
            "icon": "04n"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 16.64,
        "feels_like": 15.93,
        "temp_min": 15.31,
        "temp_max": 17.29,
        "pressure": 1013,
        "humidity": 60,
        "sea_level": 1013,
        "grnd_level": 996
    },
    "visibility": 10000,
    "wind": {
        "speed": 1.65,
        "deg": 259,
        "gust": 2.85
    },
    "clouds": {
        "all": 100
    },
    "dt": 1655578110,
    "sys": {
        "type": 1,
        "id": 9029,
        "country": "RU",
        "sunrise": 1655513057,
        "sunset": 1655576218
    },
    "timezone": 10800,
    "id": 524901,
    "name": "Москва",
    "cod": 200
}
""".data(using: .utf8)!
