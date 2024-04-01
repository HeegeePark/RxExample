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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        // share: subscribe() 할때마다 새로운 Observable 시퀀스가 생성되지 않고, 하나의 시퀀스에서 방출되는 아이템을 공유해 사용
        // replay: 버퍼의 크기, 다른 시퀀스에서 share()된 Observable을 구독했을 때, 가장 최근 방출했던 아이템을 버퍼의 크기만큼 새로운 구독 시퀀스에 전달
        // 여러 시퀀스에서 사용하게 되는 Observable은 subscribe() 할때마다 subscription이 생성되니 share()해서 사용해야 함
        // 보통 share(replay: 1) 형태로 사용
        // 참고: https://jusung.github.io/shareReplay/
        
        let usernameValid = usernameOutlet.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid)
        { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingOutlet.rx.tap
            .bind(with: self) { owner, _ in
                owner.showAlert(title: "RxExample", message: "This is wonderful", ok: "Ok", handler: {})
            }
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
