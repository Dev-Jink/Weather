//
//  CityListViewModel.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import Foundation
import RxSwift
import RxCocoa

class CityListViewModel {
    let cities: BehaviorRelay<[City]> = BehaviorRelay(value: [])
    let filteredCities: BehaviorRelay<[City]> = BehaviorRelay(value: [])
    let searchText: BehaviorRelay<String> = BehaviorRelay(value: "")
    private let disposeBag = DisposeBag()

    init() {
        loadCities()
        bindSearch()
    }
    
    private func loadCities() {
        guard let url = Bundle.main.url(forResource: "reduced_citylist", withExtension: "json") else {
            print("Failed to locate file.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let cities = try JSONDecoder().decode([City].self, from: data)
            self.cities.accept(cities)
            self.filteredCities.accept(cities)
        } catch {
            print(" fail to load or parse file: \(error)")
        }
    }
    
    private func bindSearch() {
        searchText
            .distinctUntilChanged()
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                if text.isEmpty {
                    self.filteredCities.accept((self.cities.value))
                } else {
                    let filtered = self.cities.value.filter {
                        $0.name.lowercased().contains(text.lowercased())
                    }
                    self.filteredCities.accept(filtered)
                }
            })
            .disposed(by: disposeBag)
    }
}
