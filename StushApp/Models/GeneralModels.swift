//
//  GeneralModels.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 8/22/23.
//

import Foundation

enum ResourceState {
    case loading
    case success
    case failure
}

struct Resource<T: Codable> {
    var data: T? {
        didSet {
            loading = false
            state = .success
        }
    }
    var error: HTTPError? {
        didSet {
            loading = false
            state = .failure
        }
    }
    
    var loading: Bool = true {
        didSet {
            if loading == true {
                state = .loading
            }
        }
    }
    
    var state : ResourceState = .loading
}

enum HTTPError: Error {
    case transportError(Error)
    case serverSideError(String)
    case noConnectionError(String)
    
    var localizedDescription : String {
        switch self {
        case .transportError(let error):
            return error.localizedDescription
        case .serverSideError(let string):
            return string
        case .noConnectionError(let string):
            return string
        }
    }
}

struct CustomError: LocalizedError {
    var description: String?

    init(description: String) {
        self.description = description
    }
}

struct NotSuccessModel:Codable {
    let isError: Bool?
    let message: String?
}

struct EmptyModel: Codable {}

enum QuantumValue: Codable {
    case int(Int), string(String)
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        
        throw QuantumError.missingValue
    }
    
    enum QuantumError:Error {
        case missingValue
    }
}

struct DefaultStringResponse: Codable {
    let responseStr: String
}

