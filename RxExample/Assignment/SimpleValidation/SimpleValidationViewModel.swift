//
//  SimpleValidationViewModel.swift
//  RxExample
//
//  Created by 박희지 on 4/4/24.
//

import UIKit
import RxSwift
import RxCocoa

enum Rule {
    static let minimalUsernameLength = 5
    static let minimalPasswordLength = 5
}

final class SimpleValidationViewModel {

    
    // Inputs
    let usernameText = BehaviorRelay<String>(value: "")
    let passwordText = BehaviorRelay<String>(value: "")
    
    // Outputs
    let usernameValidationText: Driver<String>
    let passwordValidationText: Driver<String>
    let isEverythingValid: Driver<Bool>
    
    private let disposeBag = DisposeBag()
    
    init() {
        usernameValidationText = usernameText.map { username in
            return username.count >= Rule.minimalUsernameLength ? "" : "Username has to be at least \(Rule.minimalUsernameLength) characters"
        }.asDriver(onErrorJustReturn: "")
        
        passwordValidationText = passwordText.map { password in
            return password.count >= Rule.minimalPasswordLength ? "" : "Password has to be at least \(Rule.minimalPasswordLength) characters"
        }.asDriver(onErrorJustReturn: "")
        
        let isUsernameValid = usernameText.map { $0.count >= Rule.minimalUsernameLength }
        let isPasswordValid = passwordText.map { $0.count >= Rule.minimalPasswordLength }
        
        isEverythingValid = Observable.combineLatest(isUsernameValid, isPasswordValid) { $0 && $1 }
            .asDriver(onErrorJustReturn: false)
    }
}

