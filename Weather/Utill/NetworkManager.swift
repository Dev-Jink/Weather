//
//  NetworkManager.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import Foundation
import RxSwift
import Alamofire
let apiKey = ""

class NetworkManager {
    static let shared = NetworkManager()
    
    private let OpenWeatherAPIUrl = "http://api.openweathermap.org/data/2.5/"
    
    private init() {
        
    }
    
    
    public func fetchForecastWeather(coord: Coord) -> Observable<WeatherResponse> {
        return Observable.create { observer -> Disposable in
            
            var url = URL(string: self.OpenWeatherAPIUrl+Endpoint.forecast.rawValue)!
            
            url.append(queryItems: [
                URLQueryItem(name: "lat", value: "\(coord.lat)"),
                URLQueryItem(name: "lon", value: "\(coord.lon)"),
                URLQueryItem(name: "appid", value: apiKey)
            ])
            
            print("requestUrl: \(url)")
            
            let request = AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                        observer.onNext(weatherResponse)
                        observer.onCompleted()
                    } catch let decodingError {
                        print("error: \(decodingError.localizedDescription)")
                        observer.onError(decodingError)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}

extension NetworkManager {
    enum Endpoint: String, CaseIterable {
        case forecast = "forecast"
    }
}
