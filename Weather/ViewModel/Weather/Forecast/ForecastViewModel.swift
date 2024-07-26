//
//  ForecastViewModel.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/26/24.
//

import Foundation
import RxSwift
import RxCocoa

class ForecastViewModel: ViewModel {
    var disposeBag = DisposeBag()
    let sections = BehaviorRelay<[SectionOfBasicData]>(value: [])
    
    var forecastOutput: Driver<[Forecast]>? = nil
    
    init() {
       
    }
}
