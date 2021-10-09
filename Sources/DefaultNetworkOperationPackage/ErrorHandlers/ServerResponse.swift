//
//  ServerResponse.swift
//  
//
//  Created by Emircan Aydın on 9.10.2021.
//

import Foundation

public class ServerResponse: Codable, Error {
    public let returnMessage: String?
    public let returnCode: Int?

    public init(returnMessage: String? = nil, returnCode: Int? = nil) {
        self.returnMessage = returnMessage
        self.returnCode = returnCode
    }
}
