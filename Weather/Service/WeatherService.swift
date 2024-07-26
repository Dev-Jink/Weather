//
//  WeatherService.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/26/24.
//

import Foundation
import Alamofire
import RxSwift
protocol Service {
    var NM: NetworkManager { get set }
}

class WeatherService: Service {
    var NM: NetworkManager = NetworkManager.shared
    
    func fetchForcastWeatherData(coord: Coord) -> Observable<(CityWeather, [Forecast], [WeatherDetails], Location, WeatherMetrics)> {
        
        return NM.fetchForecastWeather(coord: coord).map {
            
            func filterDuplicates(_ list: [WeatherData]) -> [WeatherData] {
                var seenDates = Set<Int>()
                return list.filter { item in
                    if seenDates.contains(item.dtFormatting()) {
                        return false
                    } else {
                        seenDates.insert(item.dtFormatting())
                        return true
                    }
                }
            }
            
            let sortedTempMax = $0.list.sorted {
                if $0.dtFormatting() == $1.dtFormatting() {
                    return $0.main.temp_max > $1.main.temp_max
                } else {
                    return $0.dtFormatting() < $1.dtFormatting()
                }
            }
           
            let sortedTempMin = $0.list.sorted {
                if $0.dtFormatting() == $1.dtFormatting() {
                    return $0.main.temp_min < $1.main.temp_min
                } else {
                    return $0.dtFormatting() < $1.dtFormatting()
                }
            }
            
            
            let filteredTempMax = filterDuplicates(sortedTempMax)
            let filteredTempMin = filterDuplicates(sortedTempMin)
       
            let groupedByDate = Dictionary(grouping: $0.list) { item in
                item.dtFormatting()
            }
            
            let averageMetrics = groupedByDate.mapValues { items -> WeatherMetrics in
                let totalWindSpeed = items.reduce(0.0) { $0 + ($1.wind.speed) }
                let totalpressure = items.reduce(0.0) { $0 + Double(($1.main.pressure)) }
                let totalHumidity = items.reduce(0.0) { $0 + Double(($1.main.humidity)) }
                let totalCloud = items.reduce(0.0) { $0 + Double(($1.clouds.all)) }
                
                let count = Double(items.count)
                
                return WeatherMetrics(humidity: Int(totalHumidity / count), clouds: Int(totalCloud / count), wind: round(totalWindSpeed/count*100)/100, pressure: Int(totalpressure / count))
            }
            
            
            let weatherDetailslist = filteredTempMin.enumerated().map{ e in
                WeatherDetails(
                    icon: e.element.weather.first?.icon ?? "Unknown",
                    tempMin: filteredTempMin[e.offset].main.temp_min,
                    tempMax: filteredTempMax[e.offset].main.temp_max,
                    dt: e.element.dt
                )
            }
            
    
            return (
                CityWeather(cityName: $0.city.name,
                            temp: Int(($0.list.first?.main.temp ?? 0.0) - 273.15),
                            tempMax: Int(($0.list.first?.main.temp_max ?? 0.0) - 273.15),
                            tempMin: Int(($0.list.first?.main.temp_min ?? 0.0) - 273.15),
                            description: $0.list.first?.weather.first?.main.description ?? "Unknown"),
                $0.list.map { Forecast(icon: $0.weather.first?.icon ?? "Unknown", 
                                       dt: $0.dt,
                                       temp: Int($0.main.temp - 273.15))},
                weatherDetailslist,
                Location(lat: $0.city.coord.lat, lon: $0.city.coord.lon),
                averageMetrics[$0.list.first?.dtFormatting() ?? 0] ?? WeatherMetrics(humidity: -1, clouds: -1, wind: -1, pressure: -1)
                )
            
        }
    }
    
}

