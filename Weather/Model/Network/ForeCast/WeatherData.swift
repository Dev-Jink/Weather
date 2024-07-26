//
//  Weather.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import Foundation

struct WeatherData: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int?
    let pop: Double?
    let rain: Precipitation?
    let snow: Precipitation?
    let sys: Sys
    let dt_txt: String
    let day: String?
    
    init(dt: Int, main: Main, weather: [Weather], clouds: Clouds, wind: Wind, visibility: Int?, pop: Double?, rain: Precipitation?, snow: Precipitation?, sys: Sys, dt_txt: String, day: String? = nil) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.clouds = clouds
        self.wind = wind
        self.visibility = visibility
        self.pop = pop
        self.rain = rain
        self.snow = snow
        self.sys = sys
        self.dt_txt = dt_txt
        let date = Date(timeIntervalSince1970: TimeInterval(self.dt))
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EE"
        self.day = dateformatter.string(from: date)
    }
    
    func dtFormatting(string:String = "yyyymmdd") -> Int {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = string
        return Int(dateformatter.string(from: date)) ?? 0
    }
    
    
}
