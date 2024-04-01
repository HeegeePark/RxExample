//
//  NumbersViewController.swift
//  RxExample
//
//  Created by 박희지 on 4/2/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class NumbersViewController: BaseViewController {
    
    private let number1 = UITextField()
    private let number2 = UITextField()
    private let number3 = UITextField()
    
    private let plus = {
        let view = UILabel()
        view.text = "+"
        view.textColor = .label
        view.font = .systemFont(ofSize: 20)
        view.sizeToFit()
        return view
    }()
    
    private let lineView = {
        let view = UIView()
        view.backgroundColor = .label
        return view
    }()
    
    private let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        Observable.combineLatest(number1.rx.text.orEmpty,
                                 number2.rx.text.orEmpty,
                                 number3.rx.text.orEmpty)
        { value1, value2, value3 -> Int in
            return (Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)
        }
        .map(\.description)
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        [number1, number2, number3, plus, lineView, resultLabel].forEach { subview in
            view.addSubview(subview)
        }
    }
    
    override func configureLayout() {
        number3.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        number2.snp.makeConstraints { make in
            make.height.equalTo(number3)
            make.horizontalEdges.equalTo(number3)
            make.bottom.equalTo(number3.snp.top).offset(-8)
        }
        
        number1.snp.makeConstraints { make in
            make.height.equalTo(number3)
            make.horizontalEdges.equalTo(number3)
            make.bottom.equalTo(number2.snp.top).offset(-8)
        }
        
        plus.snp.makeConstraints { make in
            make.trailing.equalTo(number3.snp.leading).offset(-8)
            make.centerY.equalTo(number3)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(number3.snp.bottom).offset(8)
            make.leading.equalTo(plus)
            make.trailing.equalTo(number3)
            make.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.height.equalTo(number3)
            make.horizontalEdges.equalTo(number3)
        }
    }
    
    override func configureView() {
        [number1, number2, number3].forEach {
            $0.textColor = .label
            $0.font = .systemFont(ofSize: 15)
            $0.layer.borderColor = UIColor.blue.cgColor
            $0.layer.borderWidth = 1
            $0.textAlignment = .right
        }
        
        resultLabel.text = "0"
        resultLabel.textColor = .label
        resultLabel.font = .systemFont(ofSize: 17, weight: .bold)
        resultLabel.textAlignment = .right
    }

}
