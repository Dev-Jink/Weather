//
//  ForecastItemCell.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/26/24.
//

import Foundation
import UIKit
import SnapKit

import UIKit
import SnapKit

class ForecastHourlyItemCell: UICollectionViewCell {
    static let cellId = "ForecastItemCell"
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.text = ""
        return label
    }()
    
    let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(temperatureLabel)
        
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.right.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
        
    }
}
