//
//  AuthenticationViewModel.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/11/23.
//

import Foundation
import RxSwift
import RxCocoa

class AuthenticationViewModel{
    let disposeBag = DisposeBag()
    let loginData = PublishSubject<Resource<LoginResponseModel>>()
    let generalData = PublishSubject<Resource<GeneralResponseModel>>()
    static let shared = AuthenticationViewModel()
    
    private init(){}
    
    
    func login(requestModel: LoginRequestModel) {
        PostRXAPIGeneric<LoginRequestModel, LoginResponseModel>
            .postRxRequest(apiURL: API.Auth.LOGIN, requestModel: requestModel, bag: disposeBag)
            .subscribe { [weak self] (event) in
                if let element = event.element {
                    if element.state == .success {
                        if let obj = element.data {
                            
                        }
                    }
                    self?.loginData.onNext(element)
                }
            }.disposed(by: disposeBag)
    }
    
    func signUp(requestModel: SignUpRequestModel) {
        PostRXAPIGeneric<SignUpRequestModel, GeneralResponseModel>
            .postRxRequest(apiURL: API.Auth.SIGNUP, requestModel: requestModel, bag: disposeBag)
            .subscribe { [weak self] (event) in
                if let element = event.element {
                    if element.state == .success {
                    }
                    self?.generalData.onNext(element)
                }
            }.disposed(by: disposeBag)
    }
    
    func forgotPass(requestModel: ForgotPassRequestModel) {
        PostRXAPIGeneric<ForgotPassRequestModel, GeneralResponseModel>
            .postRxRequest(apiURL: API.Auth.FORGOT_PASSWORD, requestModel: requestModel, bag: disposeBag)
            .subscribe { [weak self] (event) in
                if let element = event.element {
                    if element.state == .success {
                    }
                    self?.generalData.onNext(element)
                }
            }.disposed(by: disposeBag)
    }
    
}

