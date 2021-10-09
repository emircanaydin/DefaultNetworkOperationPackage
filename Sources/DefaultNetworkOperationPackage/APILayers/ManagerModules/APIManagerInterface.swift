//
//  APIManagerInterface.swift
//  CartCodeCase
//
//  Created by Emircan Aydın on 9.10.2021.
//

import Foundation

public protocol APIManagerInterface {
    func executeRequest<R: Codable>(urlRequest: URLRequest, completion: @escaping (Result<R, ErrorResponse>) -> Void)
}
