//
//  HooleyPostApi.swift
//  hooley
//
//  Created by Ahmad Rafiq on 10/25/18.
//  Copyright © 2018 messagemuse. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class RXAPIGeneric<response: Codable> {
    
    static func fetchRxRequest(apiURL: String, requiresAuthentication: Bool = false, bag: DisposeBag) -> Observable<Resource<response>> {
        
        Observable.create { observer in
            var resource = Resource<response>(data: nil, error: nil, loading: true)
            observer.onNext(resource)
            
            NetworkManager.shared.fetchNetworkData(requestType: .get, fromURL: apiURL, parameters: [:], requiresAuthentication: requiresAuthentication)?.subscribe({ event in
                
                if let element = event.element {
                    if let error = element.error {
                        resource.error = error
                    }
                    else {
                        do {
                            let jsonResponse = try JSONSerialization.jsonObject(with: element.data!, options: [])
                            print(jsonResponse)
                            
                            if (jsonResponse as? NSArray)?.count == 0 {
                                resource.error = .serverSideError(Constants.kEmptyResponseError)
                            }
                            else {
                                if(element.statusCode == 401) {
                                    AlertPopupService.sharedInstance.showSessionTimeoutAlert()
                                }
                                else if element.statusCode >= 200 && element.statusCode < 300 {
                                    let responseModel = try JSONDecoder().decode(response.self, from: element.data!)
                                    resource.data = responseModel
                                }
                                else {
                                    let responseModel = try JSONDecoder().decode(NotSuccessModel.self, from: element.data!)
                                    resource.error = .serverSideError(responseModel.message ?? "")
                                }
                            }
                        } catch let error {
                            do {
                                let responseModel = try JSONDecoder().decode(NotSuccessModel.self, from: element.data!)
                                resource.error = .serverSideError(responseModel.message ?? error.localizedDescription)
                            }
                            catch let error {
                                resource.error = .serverSideError(error.localizedDescription)
                            }
                        }
                    }
                } else {
                    resource.state = .failure
                }
                observer.onNext(resource)
            })
            .disposed(by: bag)
            
            return Disposables.create()
        }
    }
}

class PostRXAPIGeneric<request: Codable ,response: Codable> {
    static func postRxRequest(apiURL: String, requestType: RequestType = .post, requestModel: request, requiresAuthentication: Bool = false, bag: DisposeBag) -> Observable<Resource<response>> {
        
        
        Observable.create { observer in
            
            var resource = Resource<response>(data: nil, error: nil, loading: true)
            observer.onNext(resource)
            
            if let parameters = requestModel.dictionary {
                
                NetworkManager.shared.fetchNetworkData(requestType: requestType, fromURL: apiURL, parameters: parameters, requiresAuthentication: requiresAuthentication)?
                    .subscribe({ event in
                        
                        if let element = event.element {
                            if let err = element.error {
                                resource.error = err
                            } else {
                                do {
                                    let jsonResponse = try JSONSerialization.jsonObject(with: element.data!, options: [])
                                    print(jsonResponse)
                                    
                                    if (jsonResponse as? NSArray)?.count == 0 {
                                        resource.error = .serverSideError(Constants.kEmptyResponseError)
                                    }
                                    else {
                                        if(element.statusCode == 401) {
                                            AlertPopupService.sharedInstance.showSessionTimeoutAlert()
                                        }
                                        else if element.statusCode >= 200 && element.statusCode < 300{
                                            let responseModel = try JSONDecoder().decode(response.self, from: element.data!)
                                            resource.data = responseModel
                                        } else {
                                            let responseModel = try JSONDecoder().decode(NotSuccessModel.self, from: element.data!)
                                            resource.error = .serverSideError(responseModel.message ?? "")
                                        }
                                    }
                                } catch {
                                    do {
                                        let responseModel = try JSONDecoder().decode(NotSuccessModel.self, from: element.data!)
                                        resource.error = .serverSideError(responseModel.message ?? "")
                                    }
                                    catch let error {
                                        resource.error = .serverSideError(error.localizedDescription)
                                    }
                                }
                            }
                        } else {
                            resource.state = .failure
                        }
                        observer.onNext(resource)
                    })
                    .disposed(by: bag)
            } else {
                resource.state = .failure
                observer.onNext(resource)
            }
            
            return Disposables.create()
        }
    }
    
    static func postRxTokenRequest(apiURL: String, requestType: RequestType = .post, requestModel: request, requiresAuthentication: Bool = false, bag: DisposeBag) -> Observable<Resource<response>> {
        Observable.create { observer in
            
            var resource = Resource<response>(data: nil, error: nil, loading: true)
            observer.onNext(resource)
            
            if let parameters = requestModel.dictionary {
                
                NetworkManager.shared.fetchNetworkData(requestType: requestType, fromURL: apiURL, parameters: parameters, requiresAuthentication: requiresAuthentication)?
                    .subscribe({ event in
                        
                        if let element = event.element {
                            if let err = element.error {
                                resource.error = err
                            } else {
                                do {
                                    if (element.statusCode == 401) {
                                        AlertPopupService.sharedInstance.showSessionTimeoutAlert()
                                    }
                                    else if element.statusCode == 200 {
                                        if let data = element.data , var token = String(data: data, encoding: .utf8) {
                                            token = String(token.dropFirst())
                                            token = String(token.dropLast())
                                            let responseModel = DefaultStringResponse(responseStr: token)
                                            resource.data = (responseModel as! response)
                                        } else {
                                            let errr = CustomError(description: "Something went wrong")
                                            resource.error = .transportError(errr)
                                        }
                                    } else {
                                        let responseModel = try JSONDecoder().decode(NotSuccessModel.self, from: element.data!)
                                        resource.error = .serverSideError(responseModel.message ?? "")
                                    }
                                } catch let error {
                                    resource.error = .serverSideError(error.localizedDescription)
                                }
                            }
                        } else {
                            resource.state = .failure
                        }
                        observer.onNext(resource)
                    })
                    .disposed(by: bag)
            } else {
                resource.state = .failure
                observer.onNext(resource)
            }
            
            return Disposables.create()
        }
    }
}


//class APIGeneric<response: Codable> {
//
//    static func fetchRequest(apiURL:String , requiresAuthentication: Bool = false, onCompletion: @escaping (Result<response,Error>) -> Void) {
//        print(apiURL)
//        NetworkManager.shared.fetchData(requestType: .get, fromURL: apiURL, parameters: [:], requiresAuthentication: requiresAuthentication) { (error:Error?, jsonData:Data?, statusCode: Int?) in
//
//            if let err = error {
//                let errr = CustomError(description: err.localizedDescription)
//                onCompletion(.failure(errr))
//            }else{
//                do {
//                    let jsonResponse = try JSONSerialization.jsonObject(with: jsonData!, options: [])
//                    print(jsonResponse)
//
//                    if statusCode == 200 {
//                        let responseModel = try JSONDecoder().decode(response.self, from: jsonData!)
//                        onCompletion(.success(responseModel))
//                    } else {
//                        let responseModel = try JSONDecoder().decode(NotSuccessModel.self, from: jsonData!)
//                        let error = CustomError(description: responseModel.message ?? "")
//                        onCompletion(.failure(error))
//                    }
//                } catch let error {
//                    let err = CustomError(description: error.localizedDescription)
//                    onCompletion(.failure(err))
//                }
//            }
//        }
//    }
//}

//class PostAPIGeneric<request: Codable,response: Codable> {
//
//    static func postRequest(apiURL:String, requestType: RequestType = .post ,requestModel:request, requiresAuthentication: Bool = false, onCompletion: @escaping (Result<response,Error>) -> Void) {
//
//        guard let parameters = requestModel.dictionary else { return }
//        NetworkManager.shared.fetchData(requestType: requestType, fromURL: apiURL, parameters: parameters, requiresAuthentication: requiresAuthentication) { (error:Error?, jsonData:Data?, statusCode:Int?) in
//            if let err = error{
//                let errr = CustomError(description: err.localizedDescription)
//                onCompletion(.failure(errr))
//            }else{
//                do {
//                    let jsonResponse = try JSONSerialization.jsonObject(with: jsonData!, options: [])
//                    print(jsonResponse)
//
//                    if statusCode == 200 {
//                        let responseModel = try JSONDecoder().decode(response.self, from: jsonData!)
//                        onCompletion(.success(responseModel))
//                    } else {
//                        let responseModel = try JSONDecoder().decode(NotSuccessModel.self, from: jsonData!)
//                        let error = CustomError(description: responseModel.message ?? "")
//                        onCompletion(.failure(error))
//                    }
//                } catch let error {
//                    let errr = CustomError(description: error.localizedDescription)
//                    onCompletion(.failure(errr))
//                }
//            }
//        }
//    }
//
//    static func loginTokenRequest(apiURL:String, requestType: RequestType = .post ,requestModel:request, onCompletion: @escaping (Result<String,Error>) -> Void) {
//
//        guard let parameters = requestModel.dictionary else { return }
//        NetworkManager.shared.fetchData(requestType: requestType, fromURL: apiURL, parameters: parameters) { (error:Error?, jsonData:Data?, statusCode:Int?) in
//            if let err = error{
//                let errr = CustomError(description: err.localizedDescription)
//                onCompletion(.failure(errr))
//            }else{
//                do {
//                    if statusCode == 200 {
//                        if let data = jsonData , var token = String(data: data, encoding: .utf8) {
//                            token = String(token.dropFirst())
//                            token = String(token.dropLast())
//                            onCompletion(.success(token))
//                        } else {
//                            let errr = CustomError(description: "Something went wrong")
//                            onCompletion(.failure(errr))
//                        }
//
//                    } else {
//                        let responseModel = try JSONDecoder().decode(NotSuccessModel.self, from: jsonData!)
//                        let error = CustomError(description: responseModel.message ?? "")
//                        onCompletion(.failure(error))
//                    }
//                } catch let error {
//                    let errr = CustomError(description: error.localizedDescription)
//                    onCompletion(.failure(errr))
//                }
//            }
//        }
//    }
//
//    static func cartTokenRequest(apiURL:String, requestType: RequestType = .post ,requestModel:request, requiresAuthentication: Bool = false, onCompletion: @escaping (Result<Int,Error>) -> Void) {
//
//        guard let parameters = requestModel.dictionary else { return }
//        NetworkManager.shared.fetchData(requestType: requestType, fromURL: apiURL, parameters: parameters, requiresAuthentication: true) { (error:Error?, jsonData:Data?, statusCode:Int?) in
//            if let err = error{
//                let errr = CustomError(description: err.localizedDescription)
//                onCompletion(.failure(errr))
//            }else{
//                do {
//                    if statusCode == 200 {
//                        if let data = jsonData , let token = String(data: data, encoding: .utf8) {
//                            let cartToken = Int(token) ?? 0
//                            onCompletion(.success(cartToken))
//                        } else {
//                            let errr = CustomError(description: "Something went wrong")
//                            onCompletion(.failure(errr))
//                        }
//
//                    } else {
//                        let responseModel = try JSONDecoder().decode(NotSuccessModel.self, from: jsonData!)
//                        let error = CustomError(description: responseModel.message ?? "")
//                        onCompletion(.failure(error))
//                    }
//                } catch let error {
//                    let errr = CustomError(description: error.localizedDescription)
//                    onCompletion(.failure(errr))
//                }
//            }
//        }
//    }
//
//}
