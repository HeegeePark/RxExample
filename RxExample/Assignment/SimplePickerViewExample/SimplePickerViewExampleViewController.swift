//
//  SimplePickerViewExampleViewController.swift
//  RxExample
//
//  Created by 박희지 on 4/2/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SimplePickerViewExampleViewController: BaseViewController {
    
    private var pickerView1 = UIPickerView()
    private var pickerView2 = UIPickerView()
    private var pickerView3 = UIPickerView()

    private let viewModel = SimplePickerViewExampleViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        viewModel.itemsPicker1
            .bind(to: pickerView1.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        pickerView1.rx.modelSelected(Int.self)
            .map { $0.first ?? 0 }
            .bind(to: viewModel.selectedRowPicker1)
            .disposed(by: disposeBag)
        
        viewModel.itemsPicker2
            .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                          ])
            }
            .disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .map { $0.first ?? 0 }
            .bind(to: viewModel.selectedRowPicker2)
            .disposed(by: disposeBag)
        
        viewModel.itemsPicker3
            .bind(to: pickerView3.rx.items) { _, element, _ in
                let view = UIView()
                view.backgroundColor = element
                return view
            }
            .disposed(by: disposeBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .map { $0.first ?? .clear }
            .bind(to: viewModel.selectedColorPicker3)
            .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        view.addSubview(pickerView1)
        view.addSubview(pickerView2)
        view.addSubview(pickerView3)
    }
    
    override func configureLayout() {
        let height: CGFloat = 200
        
        pickerView1.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(height)
        }
        
        pickerView2.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalToSuperview()
            make.height.equalTo(height)
        }
        
        pickerView3.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(height)
        }
    }
}
