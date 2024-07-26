//
//  SearchViewController.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

class SearchViewController: UIViewController, UISearchResultsUpdating {
    let tableView = UITableView()
    let viewModel: CityListViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: CityListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindViewModel()
    }
    
    private func setupTableView() {
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.cellId)
        
        tableView.backgroundColor = UIColor(red: 0.16, green: 0.26, blue: 0.44, alpha: 1.0)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel.filteredCities
            .bind(to: tableView.rx.items(cellIdentifier: CityCell.cellId, cellType:  CityCell.self)) { (index, city: City, cell) in
                cell.cityLabel.text = city.name
                cell.countryLabel.text = city.country
                
                cell.backgroundColor = .clear
                cell.textLabel?.textColor = .white
                cell.detailTextLabel?.textColor = .white
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(City.self)
            .subscribe(onNext: { [weak self] city in
                print("Selected city: \(city.name)")
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe { [weak self] index in
            self?.tableView.deselectRow(at: index, animated: true)
        }
        .disposed(by: disposeBag)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.searchText.accept(searchText)
    }
}
