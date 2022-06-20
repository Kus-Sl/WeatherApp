//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Вячеслав Кусакин on 19.06.2022.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func fetchData(url: String, completion: @escaping (Result<WeatherData, NetworkErrors>) -> Void ) {
        guard let dataURL = URL(string: Links.weatherMoscow.rawValue) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: dataURL) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let result = try decoder.decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }

    func fetchImage(url: String, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
        guard let iconURL = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        DispatchQueue.global().async {
            guard let iconData = try? Data(contentsOf: iconURL) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(iconData))
            }
        }
    }

    enum NetworkErrors: Error {
        case invalidURL
        case noData
        case decodingError
    }
}
    enum Links: String {
        case weatherMoscow = "https://api.openweathermap.org/data/2.5/weather?q=moscow&appid=28abb8964d438f713e801288761298d4&units=metric&lang=ru"
        case weatherIcon = "https://openweathermap.org/img/wn/"
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
