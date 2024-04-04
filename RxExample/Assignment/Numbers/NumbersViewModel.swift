//
//  NumbersViewModel.swift
//  RxExample
//
//  Created by 박희지 on 4/4/24.
//

import UIKit
import RxSwift
import RxCocoa

final class NumbersViewModel {
    // Inputs
    let number1Text = BehaviorRelay<String>(value: "")
    let number2Text = BehaviorRelay<String>(value: "")
    let number3Text = BehaviorRelay<String>(value: "")
    
    // Outputs
    let resultText: Observable<String>
    
    private let disposeBag = DisposeBag()
    
    init() {
        resultText = Observable.combineLatest(number1Text.asObservable(),
                                              number2Text.asObservable(),
                                              number3Text.asObservable())
        { value1, value2, value3 -> Int in
            return (Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)
        }
        .map(\.description)
    }
}
