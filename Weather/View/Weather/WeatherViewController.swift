//
//  ViewController.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources
import Kingfisher
import CoreLocation

class WeatherViewController: UIViewController {
    
    let tableView = UITableView()
    let cityListViewModel = CityListViewModel()
    let weatherInfoViewModel = WeatherInfoViewModel(service: WeatherService())
    
    let searchVC: SearchViewController
    
    private let disposeBag = DisposeBag()
    
    init() {
        self.searchVC = SearchViewController(viewModel: cityListViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupSearchController()
        bindViewModel()
    }
    
    private func setupUI() {
        tableView.register(CityWeatherCell.self, forCellReuseIdentifier: CityWeatherCell.cellId)
        tableView.register(ForecastHourlyCell.self, forCellReuseIdentifier: ForecastHourlyCell.cellId)
        tableView.register(ForecastDailyItemCell.self, forCellReuseIdentifier: ForecastDailyItemCell.cellId)
        tableView.register(MapViewCell.self, forCellReuseIdentifier: MapViewCell.cellId)
        tableView.register(WeatherMetricsCell.self, forCellReuseIdentifier: WeatherMetricsCell.cellId)
        tableView.separatorStyle = .none
        tableView.allowsSelectionDuringEditing = false
        tableView.backgroundView = UIImageView(image: UIImage(named: "sunny"))
        
        view.addSubview(tableView)
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfBasicData>(configureCell: { [self] dataSource, tableView, indexPath, item in
            if let cell = tableView.dequeueReusableCell(withIdentifier: CityWeatherCell.cellId, for: indexPath) as? CityWeatherCell,
               indexPath.section == 0 {
                if let cityWeqther = item as? CityWeather {
                    if cityWeqther.description.lowercased() == "clear" {
                        tableView.backgroundView = UIImageView(image: UIImage(named: "sunny"))
                    } else {
                        tableView.backgroundView = UIImageView(image: UIImage(named: cityWeqther.description.lowercased()))
                    }
                    cell.cityName.text = cityWeqther.cityName
                    cell.cityName.textColor = .white
                    cell.descriptionLabel.text = cityWeqther.description
                    cell.descriptionLabel.textColor = .white
                    cell.temp.text = "\(cityWeqther.temp)°C"
                    cell.temp.textColor = .white
                    cell.tempMaxMin.text = "Max \(cityWeqther.tempMax)°C / min \(cityWeqther.tempMin)°C"
                    cell.tempMaxMin.textColor = .white
                }
                cell.backgroundColor = .clear
                return cell
            }
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: ForecastHourlyCell.cellId, for: indexPath) as? ForecastHourlyCell,
               indexPath.section == 1 {
                if let forecast = item as? [Forecast] {
                    cell.viewModel.forecastOutput = Observable.just(forecast).asDriver(onErrorJustReturn: [])
                    cell.viewModel.forecastOutput?.drive(onNext: { forecastList in
                        cell.viewModel.sections.accept([SectionOfBasicData(header: "forecest", items: forecastList as [Any])])
                    }).disposed(by: disposeBag)
                    
                }
                return cell
            }
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: ForecastDailyItemCell.cellId, for: indexPath) as? ForecastDailyItemCell,
               indexPath.section == 2 {
                if let weatherDetail = item as? WeatherDetails {
                    if indexPath.row != 0 {
                        cell.dayLabel.text = weatherDetail.day
                    } else {
                        cell.dayLabel.text = "Today"
                    }
                    cell.tempRangeLabel.text = "Max \(weatherDetail.tempMax)°C / Min \(weatherDetail.tempMin)°C"
                    if let url = URL(string: "https://openweathermap.org/img/wn/\(weatherDetail.icon)@2x.png") {
                        cell.weatherIcon.kf.setImage(with: url)
                    }
                    
                }
                return cell
            }
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: MapViewCell.cellId, for: indexPath) as? MapViewCell,
               indexPath.section == 3 {
                if let location = item as? Location {
                    cell.location = CLLocation(latitude: location.lat, longitude: location.lon)
                }
                cell.backgroundColor = .clear
                return cell
            }
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherMetricsCell.cellId, for: indexPath) as? WeatherMetricsCell,
               indexPath.section == 4 {
                if let weatherMetrics = item as? WeatherMetrics {
                    cell.humidityValueLabel.text = "\(weatherMetrics.humidity)%"
                    cell.pressureValueLabel.text = "\(weatherMetrics.pressure)"
                    cell.cloudsValueLabel.text = "\(weatherMetrics.clouds)%"
                    cell.windSpeedValueLabel.text = "\(weatherMetrics.wind)"
                }
                cell.backgroundColor = .clear
                return cell
            }
            return UITableViewCell()
        })
        
        self.weatherInfoViewModel.sections.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: searchVC)
        searchController.searchResultsUpdater = searchVC
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"
        searchController.showsSearchResultsController = true
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.searchTextField.backgroundColor = .lightGray
        searchController.searchBar.searchTextField.tintColor = .white
        searchController.searchBar.tintColor = .white
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
    }
    
    private func bindViewModel() {
        searchVC.tableView.rx.modelSelected(City.self)
            .subscribe(onNext: { [weak self] city in
                self?.weatherInfoViewModel.searchforeCastWeather(coord: Coord(lat: city.coord.lat, lon: city.coord.lon))
                print("Selected city: \(city.name)")
                
            })
            .disposed(by: disposeBag)
        
        weatherInfoViewModel.weatherForecastResponse.drive(onNext: { [weak self] (cityWeather, forecastList, weatherDetailList, location, weatherMetrics) in
            guard let self = self else {
                return
            }
            
            self.weatherInfoViewModel.sections.accept([SectionOfBasicData(header: "cityWeather", items: [cityWeather as Any]),
                                                       SectionOfBasicData(header: "forecastList", items: [forecastList as Any]),
                                                       SectionOfBasicData(header: "weatherDetailList", items: weatherDetailList as [Any]),
                                                       SectionOfBasicData(header: "location", items: [location as Any]),
                                                       SectionOfBasicData(header: "weatherMetrics", items: [weatherMetrics as Any])
                                                      ])
           
        })
        .disposed(by: disposeBag)
        
        
        weatherInfoViewModel.searchforeCastWeather(coord: Coord(lat: 36.783611, lon: 127.004173))
        
    }
}
