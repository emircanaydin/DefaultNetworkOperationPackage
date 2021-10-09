//
//  ErrorResponse.swift
//  
//
//  Created by Emircan Aydın on 9.10.2021.
//

import Foundation

public class ErrorResponse: Error {
    public let serverResponse: ServerResponse?
    public let apiConnectionErrorType: ApiConnectionErrorType?

    public init(serverResponse: ServerResponse? = nil, apiConnectionErrorType: ApiConnectionErrorType? = nil) {
        self.serverResponse = serverResponse
        self.apiConnectionErrorType = apiConnectionErrorType
    }
}
