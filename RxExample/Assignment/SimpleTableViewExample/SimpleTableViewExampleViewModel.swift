//
//  SimpleTableViewExampleViewModel.swift
//  RxExample
//
//  Created by 박희지 on 4/4/24.
//

import UIKit
import RxSwift

class SimpleTableViewExampleViewModel {
    // Input
    let itemSelected = PublishSubject<String>()
    let itemAccessoryButtonTapped = PublishSubject<IndexPath>()
    
    // Output
    let items: Observable<[String]>
    let showAlert = PublishSubject<(title: String, message: String, ok: String, handler: () -> Void)>()

    private let disposeBag = DisposeBag()

    init() {
        items = Observable.just((0..<20).map { String($0) })
        
        itemSelected
            .map { value in  "Tapped \(value)" }
            .map { (title: "RxExample", message: $0, ok: "OK", handler: {}) }
            .bind(to: showAlert)
            .disposed(by: disposeBag)
        
        itemAccessoryButtonTapped
            .map { indexPath in "Tapped Detail @ \(indexPath.section),\(indexPath.row)" }
            .map { (title: "RxExample", message: $0, ok: "OK", handler: {}) }
            .bind(to: showAlert)
            .disposed(by: disposeBag)
    }
}
