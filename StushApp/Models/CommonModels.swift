//
//  CommonModels.swift
//  StushApp
//
//  Created by Shahzeb Haroon on 9/21/23.
//

import Foundation

struct GetStatesResponseModel: Codable {
    let data: [StatesItem]
    let isError: Bool
    let message: String
}

// MARK: - Datum
struct StatesItem: Codable {
    let code, name: String
}
