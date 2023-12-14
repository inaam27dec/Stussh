//
//  CommonViewModel.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/21/23.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel {
    
    let statesResponse = PublishSubject<Resource<GetStatesResponseModel>>()
    let disposeBag = DisposeBag()
    
    static let shared = CommonViewModel()
    
    private init(){}
    
    func fetchStates(){
        RXAPIGeneric<GetStatesResponseModel>.fetchRxRequest(apiURL: API.Auth.GET_STATES ,requiresAuthentication: false, bag: disposeBag)
            .subscribe({ [weak self] (event) in
                if let element = event.element {
                    self?.statesResponse.onNext(element)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
