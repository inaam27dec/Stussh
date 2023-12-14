//
//  ProfileViewModel.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/20/23.
//


import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {
    
    let myProfileData = PublishSubject<Resource<ProfileResponseModel>>()
    let profileUpdated = PublishSubject<Resource<GeneralResponseModel>>()
    let disposeBag = DisposeBag()
    
    static let shared = ProfileViewModel()
    
    private init(){}
    
    func fetchUserProfiles(){
        let uuid = UserDefaultsHandler.sharedInstance.getMyUserObj()?.uid
        
        RXAPIGeneric<ProfileResponseModel>.fetchRxRequest(apiURL: API.Profile.GET_PROFILE.replacingOccurrences(of: "{uid}", with: String(uuid ?? "")), requiresAuthentication: true, bag: disposeBag)
            .subscribe({ [weak self] (event) in
                if let element = event.element {
                    self?.myProfileData.onNext(element)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func updateUserProfile(requestModel: EditProfileRequestModel) {
        PostRXAPIGeneric<EditProfileRequestModel, GeneralResponseModel>
            .postRxRequest(apiURL: API.Profile.UPDATE_PROFILE, requestModel: requestModel, requiresAuthentication: true, bag: disposeBag)
            .subscribe { [weak self] (event) in
                if let element = event.element {
                    if element.state == .success {
                        if let obj = element.data {
                        }
                    }
                    self?.profileUpdated.onNext(element)
                }
            }.disposed(by: disposeBag)
    }
    
}
