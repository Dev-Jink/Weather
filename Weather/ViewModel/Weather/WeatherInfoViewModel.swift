//
//  WeatherInfoViewModel.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import Foundation
import RxSwift
import RxCocoa

class WeatherInfoViewModel: ViewModel {
    var disposeBag = DisposeBag()
    
    let sections = BehaviorRelay<[SectionOfBasicData]>(value: [])
    
    let coord = PublishSubject<Coord>()
    
    let service: WeatherService
    
    
    let weatherForecastResponse: Driver<(CityWeather, [Forecast], [WeatherDetails], Location, WeatherMetrics)>
    
    init(service: WeatherService) {
        self.service = service
        
        self.weatherForecastResponse = coord
            .flatMapLatest { coord in
                return service.fetchForcastWeatherData(coord:coord)
                    .share(replay: 1)
                    .catchAndReturn((
                                    CityWeather(cityName: "Unknown", temp: 0, tempMax: 0, tempMin: 0, description: "Unknown"),
                                    [],
                                    [],
                                    Location(lat: 0, lon: 0),
                                    WeatherMetrics(humidity: 0, clouds: 0, wind: 0, pressure: 0)
                                    ))
                    
            }
            .asDriver(onErrorJustReturn: ( CityWeather(cityName: "Unknown", temp: 0, tempMax: 0, tempMin: 0, description: "Unknown"),[],[], Location(lat: 0, lon: 0), WeatherMetrics(humidity: 0, clouds: 0, wind: 0, pressure: 0) ) )
       
    }

    func searchforeCastWeather(coord: Coord) {
        self.coord.onNext(coord)
    }
}
    
    
    
    
