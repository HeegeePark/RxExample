//
//  BaseViewController.swift
//  RxExample
//
//  Created by 박희지 on 3/29/24.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
    }
    
    func configureLayout() {
    }
    
    func configureView() {
    }
    
    func showAlert(title: String, message: String, ok: String, handler: @escaping (() -> Void), showCancel: Bool = false) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: ok, style: .default) { _ in
            handler()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        if showCancel {
            alert.addAction(cancel)
        }
        
        present(alert, animated: true)
    }
}

