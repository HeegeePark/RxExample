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

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        Observable.just([1, 2, 3])
            .bind(to: pickerView1.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        pickerView1.rx.modelSelected(Int.self)
            .subscribe(with: self) { _, models in
                print("models selected 1: \(models)")
            }
            .disposed(by: disposeBag)
        
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.cyan,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                          ])
            }
            .disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .subscribe(with: self) { _, models in
                print("models selected 2: \(models)")
            }
            .disposed(by: disposeBag)
        
        Observable.just([UIColor.red, UIColor.blue, UIColor.yellow])
            .bind(to: pickerView3.rx.items) { _, element, _ in  //  (Int, Sequence.Element, UIView?)
                let view = UIView()
                view.backgroundColor = element
                return view
            }
            .disposed(by: disposeBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe(with: self) { _, models in
                print("models selected 3: \(models)")
            }
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
