//
//  ApiConnectionErrorType.swift
//  
//
//  Created by Emircan Aydın on 9.10.2021.
//

import Foundation

public enum ApiConnectionErrorType {
    case missingData(Int)
    case connectionError(Int)
    case serverError(Int)
    case dataDecodedFailed(String)
}
