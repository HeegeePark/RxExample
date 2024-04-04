//
//  SimpleValidationViewController.swift
//  RxExample
//
//  Created by 박희지 on 4/2/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

final class SimpleValidationViewController: BaseViewController {
    private let username = UILabel()
    private let usernameOutlet = UITextField()
    private let usernameValidOutlet = UILabel()
    
    private let password = UILabel()
    private let passwordOutlet = UITextField()
    private let passwordValidOutlet = UILabel()
    
    private let doSomethingOutlet = UIButton()
    
    private let viewModel = SimpleValidationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        usernameOutlet.rx.text.orEmpty
            .bind(to: viewModel.usernameText)
            .disposed(by: disposeBag)
        
        passwordOutlet.rx.text.orEmpty
            .bind(to: viewModel.passwordText)
            .disposed(by: disposeBag)
        
        viewModel.usernameValidationText
            .drive(usernameValidOutlet.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.passwordValidationText
            .drive(passwordValidOutlet.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.isEverythingValid
            .drive(doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap
            .bind(with: self, onNext: { owner, _ in
                owner.showAlert(title: "RxExample", message: "This is wonderful", ok: "Ok", handler: {})
            })
            .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        [username, usernameOutlet, usernameValidOutlet,
         password, passwordOutlet, passwordValidOutlet,
         doSomethingOutlet].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureLayout() {
        username.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(26)
        }
        
        usernameOutlet.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(username.snp.bottom).offset(8)
        }
        
        usernameValidOutlet.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(usernameOutlet.snp.bottom).offset(8)
        }
        
        password.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(usernameValidOutlet.snp.bottom).offset(8)
        }
        
        passwordOutlet.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(password.snp.bottom).offset(8)
        }
        
        passwordValidOutlet.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(passwordOutlet.snp.bottom).offset(8)
        }
        
        doSomethingOutlet.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(passwordValidOutlet.snp.bottom).offset(8)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        username.text = "Username"
        password.text = "Password"
        [username, password].forEach {
            $0.font = .systemFont(ofSize: 17)
            $0.textColor = .label
        }
        
        [usernameOutlet, passwordOutlet].forEach {
            $0.font = .systemFont(ofSize: 14)
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.borderWidth = 1
        }
        
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
        [usernameValidOutlet, passwordValidOutlet].forEach {
            $0.font = .systemFont(ofSize: 17)
            $0.textColor = .systemRed
        }
        
        doSomethingOutlet.setTitle("Do something", for: .normal)
        doSomethingOutlet.setTitleColor(.white, for: .disabled)
        doSomethingOutlet.setTitleColor(.black, for: .normal)
        doSomethingOutlet.backgroundColor = .systemGreen
    }
}
