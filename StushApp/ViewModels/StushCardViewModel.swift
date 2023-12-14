//
//  StushCardViewModel.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/23/23.
//

import Foundation
import RxSwift

class StushCardViewModel {
    let disposeBag = DisposeBag()
    let cardDetails = PublishSubject<Resource<GetStushCardResponseModel>>()
    let cardActivated = PublishSubject<Resource<GeneralResponseModel>>()
    
    static let shared = StushCardViewModel()
    
    private init(){}
    
    func getCardDetails(requestModel: GetCardDetailsRequestModel) {
        PostRXAPIGeneric<GetCardDetailsRequestModel, GetStushCardResponseModel>
            .postRxRequest(apiURL: API.StushCard.GET_DETAILS, requestModel: requestModel, requiresAuthentication: true, bag: disposeBag)
            .subscribe { [weak self] (event) in
                if let element = event.element {
                    if element.state == .success {
                    }
                    self?.cardDetails.onNext(element)
                }
            }.disposed(by: disposeBag)
    }
    
    
    func activateCard(requestModel: GetCardDetailsRequestModel) {
        PostRXAPIGeneric<GetCardDetailsRequestModel, GeneralResponseModel>
            .postRxRequest(apiURL: API.StushCard.ACTIVATE_CARD, requestModel: requestModel, requiresAuthentication: true, bag: disposeBag)
            .subscribe { [weak self] (event) in
                if let element = event.element {
                    if element.state == .success {
                    }
                    self?.cardActivated.onNext(element)
                }
            }.disposed(by: disposeBag)
    }
}
