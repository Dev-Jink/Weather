//
//  CityWeatherCell.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import UIKit
import SnapKit

class CityWeatherCell: UITableViewCell {
    static let cellId = "CityWeatherCell"
    // Define the labels
    let cityName: UILabel = {
        let cityName = UILabel()
        cityName.font = UIFont.systemFont(ofSize: 20)
        cityName.textAlignment = .center
        cityName.text = "cityName"
        return cityName
    }()
    
    let temp: UILabel = {
        let temp = UILabel()
        temp.font = UIFont.systemFont(ofSize: 40)
        temp.textAlignment = .center
        temp.text = "temp"
        return temp
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "descriptionLabel"
        return descriptionLabel
    }()
    
    let tempMaxMin: UILabel = {
        let tempMaxMin = UILabel()
        tempMaxMin.font = UIFont.systemFont(ofSize: 16)
        tempMaxMin.textAlignment = .center
        tempMaxMin.text = "tempMaxMin"
        return tempMaxMin
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        // Add the labels to the content view
        contentView.addSubview(cityName)
        contentView.addSubview(temp)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(tempMaxMin)
        
        // Apply constraints using SnapKit
        cityName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        temp.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(temp.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        tempMaxMin.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }

    }
    // Required initializer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
