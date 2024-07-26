//
//  Precipitation.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import Foundation

struct Precipitation: Codable {
    let three_h: Double
    
    enum CodingKeys: String, CodingKey {
        case three_h = "3h"
    }
}
