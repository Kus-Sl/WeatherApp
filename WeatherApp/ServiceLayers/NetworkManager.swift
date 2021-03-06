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

    func fetchData(from url: String, isManualParsing: Bool = false, completion: @escaping (Result<WeatherData, NetworkErrors>) -> Void ) {
        guard let dataURL = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: dataURL) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            switch isManualParsing {
            case true:
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data)
                    DispatchQueue.main.async {
                        if let weatherData = WeatherData.getWeatherData(from: jsonData) {
                            completion(.success(weatherData))
                        }
                    }
                } catch {
                    completion(.failure(.decodingError))
                }

            case false:
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
            }
        }.resume()
    }

    func fetchImage(from url: String, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
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
}

enum NetworkErrors: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Links: String {
    case weatherMoscow = "https://api.openweathermap.org/data/2.5/weather?q=moscow&appid=28abb8964d438f713e801288761298d4&units=metric&lang=ru"
    case weatherIcon = "https://openweathermap.org/img/wn/"
}

