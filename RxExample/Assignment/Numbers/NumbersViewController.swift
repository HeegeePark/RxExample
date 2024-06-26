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
    private let plus = UILabel()
    private let lineView = UIView()
    private let resultLabel = UILabel()
    
    private let viewModel = NumbersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        viewModel.resultText
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
        
        number1.rx.text.orEmpty
            .bind(to: viewModel.number1Text)
            .disposed(by: disposeBag)
        
        number2.rx.text.orEmpty
            .bind(to: viewModel.number2Text)
            .disposed(by: disposeBag)
        
        number3.rx.text.orEmpty
            .bind(to: viewModel.number3Text)
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
