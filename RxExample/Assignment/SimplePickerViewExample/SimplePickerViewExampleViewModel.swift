//
//  SimplePickerViewExampleViewModel.swift
//  RxExample
//
//  Created by 박희지 on 4/4/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SimplePickerViewExampleViewModel {
    // Inputs
    let selectedRowPicker1 = PublishSubject<Int>()
    let selectedRowPicker2 = PublishSubject<Int>()
    let selectedColorPicker3 = PublishSubject<UIColor>()

    // Outputs
    let itemsPicker1 = Observable<[Int]>.just([1, 2, 3])
    let itemsPicker2 = Observable<[Int]>.just([1, 2, 3])
    let itemsPicker3 = Observable<[UIColor]>.just([.red, .blue, .yellow])
    
    private let disposeBag = DisposeBag()

    init() {
        selectedRowPicker1
            .subscribe(onNext: { row in
                print("models selected 1: \(row)")
            })
            .disposed(by: disposeBag)
        
        selectedRowPicker2
            .subscribe(onNext: { row in
                print("models selected 2: \(row)")
            })
            .disposed(by: disposeBag)
        
        selectedColorPicker3
            .subscribe(onNext: { color in
                print("models selected 3: \(color)")
            })
            .disposed(by: disposeBag)
    }
}
