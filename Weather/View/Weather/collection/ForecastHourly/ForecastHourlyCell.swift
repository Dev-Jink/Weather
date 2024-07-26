//
//  ForecastCell.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/26/24.
//

import Foundation
import UIKit
import RxDataSources
import RxSwift
import Kingfisher

class ForecastHourlyCell: UITableViewCell, UIScrollViewDelegate {
    static let cellId = "ForecastCell"
    let viewModel = ForecastViewModel()
    let collectionView:UICollectionView
    
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ForecastHourlyItemCell.self, forCellWithReuseIdentifier: ForecastHourlyItemCell.cellId)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.removeFromSuperview()
        self.selectionStyle = .none
        backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        addSubview(collectionView)
        
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionOfBasicData>(configureCell: { datasource, collectionView, indexPath, item in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastHourlyItemCell.cellId, for: indexPath) as? ForecastHourlyItemCell {
                if let forecast = item as? Forecast {
                    
                    cell.temperatureLabel.text = "\(forecast.temp)°C"
                    if let url = URL(string: "https://openweathermap.org/img/wn/\(forecast.icon)@2x.png") {
                       
                        cell.weatherIcon.kf.setImage(with: url)
                      
                    }
                    let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
                    let dateformat = DateFormatter()
                    dateformat.dateFormat = "HH"
                    if indexPath.row == 0 {
                        cell.timeLabel.text = "now"
                    } else {
                        cell.timeLabel.text = dateformat.string(from: date)
                    }
                }
                return cell
            }
            
            return UICollectionViewCell()
        })
        
        self.viewModel.sections.bind(to: collectionView.rx.items(dataSource: datasource)).disposed(by: disposeBag)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
            make.height.equalTo(125)
        }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 10
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    
        collectionView.backgroundColor = .gray
        collectionView.alpha = 0.8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ForecastHourlyCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 100) // 적절한 셀 크기 설정
    }
}
