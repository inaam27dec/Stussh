//
//  DataService.swift
//  HooleyAPIs
//
//  Created by Ahmad Rafiq on 1/3/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import RxSwift

enum RequestType:String {
    
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

struct NetworkResponseData {
    var statusCode: Int
    var data: Data?
    var error: HTTPError?
}

typealias Parameters = Dictionary<String,Any>

let session = URLSession.shared

class NetworkManager {
    
    static let shared = NetworkManager()
    let bag = DisposeBag()

    func fetchNetworkData(requestType: RequestType, fromURL urlStr: String, parameters: Parameters, requiresAuthentication: Bool = false) -> Observable<NetworkResponseData>? {
        
        return Observable.create({ observer in
                
            var responseEventData = NetworkResponseData(statusCode: 0, data: nil, error: nil)
            
            if !NetworkManagerUtility.isConnectedToNetwork() {
                responseEventData.error = .noConnectionError(Constants.NO_INTERNET)
                observer.onNext(responseEventData)
            } else {
                
                if let urlString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = requestType.rawValue
                    
                    if requestType.rawValue == RequestType.post.rawValue || requestType.rawValue == RequestType.put.rawValue {
                        do {
                            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }else{
                        request.cachePolicy =  NetworkManagerUtility.isConnectedToNetwork() ? .useProtocolCachePolicy : .returnCacheDataDontLoad
                    }
                    
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    
                    if requiresAuthentication {
                       
                        request.addValue("Bearer \(UserDefaultsHandler.sharedInstance.getLoginToken())", forHTTPHeaderField: "Authorization")
                
                    }
                    
                    
                    URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                        
                        if let url = request.url?.absoluteString,
                           let httpMethod = request.httpMethod,
                           let headers = request.allHTTPHeaderFields,
                           let bodyData = request.httpBody,
                           let requestBody = String(data: bodyData, encoding: .utf8) {
                            print("Request URL: \(url)")
                            print("Request Method: \(httpMethod)")
                            print("Request Headers: \(headers)")
                            print("Request Body: \(requestBody)")
                        }
                        
                        if let apiError = error {
                            responseEventData.error = .transportError(apiError)
                            observer.onNext(responseEventData)
                            
                        } else {
                            if let httpResponse = response as? HTTPURLResponse {
                                print("Status code: (\(httpResponse.statusCode))")
                                responseEventData.statusCode = httpResponse.statusCode

                                // do stuff.
                            }
                            //responseEventData.statusCode = response.statusCode
                            responseEventData.data = data
                            observer.onNext(responseEventData)
                        }

                        
                        
                        
                    }).resume()
                    
                }
                else {
                    let error = CustomError(description: "Invalid URL")
                    responseEventData.error = .transportError(error)
                    observer.onNext(responseEventData)
                }
            }
            
            return Disposables.create()
        })
    }
    
    func fetchData(requestType:RequestType,fromURL urlStr:String,parameters:Dictionary<String,Any>, requiresAuthentication: Bool = false,completionHandler:@escaping (_ error:Error?, _ jsonData:Data?, _ statusCode:Int?)->Void) -> Void {

        guard let urlString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        
        if requestType.rawValue == RequestType.post.rawValue || requestType.rawValue == RequestType.put.rawValue {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        }else{
            request.cachePolicy =  NetworkManagerUtility.isConnectedToNetwork() ? .useProtocolCachePolicy : .returnCacheDataDontLoad
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
 
        if requiresAuthentication {
            request.addValue("Bearer \(UserDefaultsHandler.sharedInstance.getLoginToken())", forHTTPHeaderField: "Authorization")
        }
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if let url = request.url?.absoluteString,
               let httpMethod = request.httpMethod,
               let headers = request.allHTTPHeaderFields,
               let bodyData = request.httpBody,
               let requestBody = String(data: bodyData, encoding: .utf8) {
                print("Request URL: \(url)")
                print("Request Method: \(httpMethod)")
                print("Request Headers: \(headers)")
                print("Request Body: \(requestBody)")
            }
            
            var statusCode : Int?

            if let httpResponse = response as? HTTPURLResponse {
                statusCode = httpResponse.statusCode
                print("statusCode: \(httpResponse.statusCode)")
                
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 401 {
                        print("Logout")
                    }
                }
            }
            
            if let error = error{
                completionHandler(error, nil, statusCode)
            }else{
                completionHandler(nil, data, statusCode)
            }
        })
        
        
        
        task.resume()
        
    }
}
