//
//  ParameterEncoder.swift
//  CartCodeCase
//
//  Created by Emircan Aydın on 9.10.2021.
//

import Foundation

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
