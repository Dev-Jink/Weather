//
//  weatherMetricsCell.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/26/24.
//

import UIKit
import SnapKit


class WeatherMetricsCell: UITableViewCell {
    static let cellId = "WeatherMetricsCell"
    
    let humidityView = UIView()
    let cloudsView = UIView()
    let windSpeedView = UIView()
    let pressureView = UIView()
    
    let humidityTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "humidity"
        label.textAlignment = .center
        return label
    }()
    
    let humidityValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    let cloudsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "clouds"
        label.textAlignment = .center
        return label
    }()
    
    let cloudsValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    let windSpeedTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "windSpeed"
        label.textAlignment = .center
        return label
    }()
    
    let windSpeedValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    let pressureTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "pressure"
        label.textAlignment = .center
        return label
    }()
    
    let pressureValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(humidityView)
        contentView.addSubview(cloudsView)
        contentView.addSubview(windSpeedView)
        contentView.addSubview(pressureView)
        
        setupView(humidityView, titleLabel: humidityTitleLabel, valueLabel: humidityValueLabel)
        setupView(cloudsView, titleLabel: cloudsTitleLabel, valueLabel: cloudsValueLabel)
        setupView(windSpeedView, titleLabel: windSpeedTitleLabel, valueLabel: windSpeedValueLabel)
        setupView(pressureView, titleLabel: pressureTitleLabel, valueLabel: pressureValueLabel)
        
        let views = [humidityView, cloudsView, windSpeedView, pressureView]
        for view in views {
            view.backgroundColor = .gray
            view.alpha = 0.8
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
        
        humidityView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(0.5).offset(-15)
            make.height.equalTo(100)
        }
        
        cloudsView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalToSuperview().multipliedBy(0.5).offset(-15)
            make.height.equalTo(100)
        }
        
        windSpeedView.snp.makeConstraints { make in
            make.top.equalTo(humidityView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(0.5).offset(-15)
            make.height.equalTo(100)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        pressureView.snp.makeConstraints { make in
            make.top.equalTo(cloudsView.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalToSuperview().multipliedBy(0.5).offset(-15)
            make.height.equalTo(100)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func setupView(_ view: UIView, titleLabel: UILabel, valueLabel: UILabel) {
        view.addSubview(titleLabel)
        view.addSubview(valueLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
