//
//  IncomeViewModel.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/21/23.
//

import Foundation
import RxSwift

class IncomeViewModel {
    let disposeBag = DisposeBag()
    let incomeProfileCreated = PublishSubject<Resource<GeneralResponseModel>>()
    
    static let shared = IncomeViewModel()
    
    private init(){}
    
    func createIncomeProfile(requestModel: CreateIncomeProfileRequestModel) {
        PostRXAPIGeneric<CreateIncomeProfileRequestModel, GeneralResponseModel>
            .postRxRequest(apiURL: API.Income.CREATE_INCOME_PROFILE, requestModel: requestModel, requiresAuthentication: true, bag: disposeBag)
            .subscribe { [weak self] (event) in
                if let element = event.element {
                    if element.state == .success {
                    }
                    self?.incomeProfileCreated.onNext(element)
                }
            }.disposed(by: disposeBag)
    }
    
    func updateIncomeProfile(requestModel: UpdateIncomeProfileRequestModel) {
        PostRXAPIGeneric<UpdateIncomeProfileRequestModel, GeneralResponseModel>
            .postRxRequest(apiURL: API.Income.UPDATE_INCOME_PROFILE, requestModel: requestModel, requiresAuthentication: true, bag: disposeBag)
            .subscribe { [weak self] (event) in
                if let element = event.element {
                    if element.state == .success {
                    }
                    self?.incomeProfileCreated.onNext(element)
                }
            }.disposed(by: disposeBag)
    }
    
}
