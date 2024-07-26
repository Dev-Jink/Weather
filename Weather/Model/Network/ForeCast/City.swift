//
//  City.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int?
    let timezone: Int?
    let sunrise: Int?
    let sunset: Int?
}
