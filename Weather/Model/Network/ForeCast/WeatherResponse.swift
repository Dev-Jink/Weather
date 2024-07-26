//
//  WeatherResponse.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import Foundation

struct WeatherResponse: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherData]
    let city: City
}
