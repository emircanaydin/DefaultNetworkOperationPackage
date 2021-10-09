//
//  HTTPHeaderFields.swift
//  CartCodeCase
//
//  Created by Emircan Aydın on 9.10.2021.
//

import Foundation

enum HTTPHeaderFields {
    
    case contentType
    
    var value: (String, String) {
        switch self {
        case .contentType:
            return ("Content-Type", "application/json; charset=utf-8")
        }
    }

}
