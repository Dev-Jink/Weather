//
//  ViewModelPr.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/25/24.
//

import Foundation
import RxSwift

protocol ViewModel {
    var disposeBag: DisposeBag {  get set }
}
