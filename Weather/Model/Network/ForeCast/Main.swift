//
//  Main.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import Foundation

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int?
    let grnd_level: Int?
    let humidity: Int
    let temp_kf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feels_like
        case temp_min
        case temp_max
        case pressure
        case sea_level
        case grnd_level
        case humidity
        case temp_kf
    }
}
