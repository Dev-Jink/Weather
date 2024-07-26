//
//  ForecastDailyItemCell.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/26/24.
//

import Foundation
import SnapKit
import UIKit

class ForecastDailyItemCell: UITableViewCell {
    static let cellId = "ForecastDailyItemCell"
    
    let dayLabel = UILabel()
    let weatherIcon = UIImageView()
    let tempRangeLabel = UILabel()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.alpha = 0.8
        contentView.backgroundColor = .gray
        selectionStyle = .none
        
        addSubview(dayLabel)
        addSubview(weatherIcon)
        addSubview(tempRangeLabel)
        
        dayLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        dayLabel.textColor = .white
        
        weatherIcon.contentMode = .scaleAspectFit
        
        tempRangeLabel.font = UIFont.systemFont(ofSize: 16)
        tempRangeLabel.textColor = .white
        
        // Layout using SnapKit
        dayLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        tempRangeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
