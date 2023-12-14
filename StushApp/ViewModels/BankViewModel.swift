//
//  BankViewModel.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/21/23.
//

import Foundation
import RxSwift
import RxCocoa

class BankViewModel {
    let disposeBag = DisposeBag()
    let accountCreated = PublishSubject<Resource<GeneralResponseModel>>()
    let bankDeleted = PublishSubject<Resource<GeneralResponseModel>>()
    
    static let shared = BankViewModel()
    
    private init(){}
    
    
    func createBankAccount(requestModel: CreateBankRequestModel) {
        PostRXAPIGeneric<CreateBankRequestModel, GeneralResponseModel>
            .postRxRequest(apiURL: API.Bank.CREATE_BANK, requestModel: requestModel, requiresAuthentication: true, bag: disposeBag)
            .subscribe { [weak self] (event) in
                if let element = event.element {
                    if element.state == .success {
                        if let obj = element.data {
                        }
                    }
                    self?.accountCreated.onNext(element)
                }
            }.disposed(by: disposeBag)
    }
    
    func updateBankAccount(requestModel: UpdateBankRequestModel) {
        PostRXAPIGeneric<UpdateBankRequestModel, GeneralResponseModel>
            .postRxRequest(apiURL: API.Bank.UPDATE_BANK, requestModel: requestModel, requiresAuthentication: true, bag: disposeBag)
            .subscribe { [weak self] (event) in
                if let element = event.element {
                    if element.state == .success {
                    }
                    self?.accountCreated.onNext(element)
                }
            }.disposed(by: disposeBag)
    }
    
    
    func markBankAsPrimary(bankUUID : String) {
        PostRXAPIGeneric<MarkAsPrimaryRequestModel, GeneralResponseModel>
            .postRxRequest(apiURL: API.Bank.MARK_AS_PRIMARY, requestModel: MarkAsPrimaryRequestModel(uid: bankUUID, userUid: UserDefaultsHandler.sharedInstance.getMyUserObj()?.uid ?? ""), requiresAuthentication: true, bag: disposeBag)
            .subscribe { [weak self] (event) in
                if let element = event.element {
                    if element.state == .success {
                    }
                    self?.accountCreated.onNext(element)
                }
            }.disposed(by: disposeBag)
    }
    
    
    func deleteBank(bankUUID : String) {
        PostRXAPIGeneric<DeleteBankRequestModel, GeneralResponseModel>
            .postRxRequest(apiURL: API.Bank.DELETE_BANK, requestModel: DeleteBankRequestModel(uid: bankUUID), requiresAuthentication: true, bag: disposeBag)
            .subscribe { [weak self] (event) in
                if let element = event.element {
                    if element.state == .success {
                    }
                    self?.bankDeleted.onNext(element)
                }
            }.disposed(by: disposeBag)
    }
}
