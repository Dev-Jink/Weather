//
//  CityCell.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import UIKit
import SnapKit

class CityCell: UITableViewCell {
    static let cellId = "CityCell"
    let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cityLabel)
        contentView.addSubview(countryLabel)
        
        cityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
