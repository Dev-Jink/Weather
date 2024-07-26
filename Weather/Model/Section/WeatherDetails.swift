//
//  WeatherDetails.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import Foundation

struct WeatherDetails: Codable {
    let icon: String
    let tempMin: Int
    let tempMax: Int
    let dt: Int
    let day: String
    
    init(icon: String, tempMin: Double, tempMax: Double, dt: Int, day: String = "") {
        self.icon = icon
        self.tempMin = Int(tempMin - 273.15)
        self.tempMax = Int(tempMax - 273.15)
        self.dt = dt
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EE"
        
        self.day = dateformatter.string(from: date)
    }
    
    func dtIntFormatting(string:String = "yyyymmdd") -> Int {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = string
        return Int(dateformatter.string(from: date)) ?? 0
    }
    
    func dtStringFormatting(string:String = "yyyymmdd") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = string
        return dateformatter.string(from: date)
    }
    
}
