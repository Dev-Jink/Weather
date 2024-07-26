//
//  CityWeather.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import Foundation

struct CityWeather: Codable {
    let cityName: String
    let temp: Int
    let tempMax: Int
    let tempMin: Int
    let description: String
}
