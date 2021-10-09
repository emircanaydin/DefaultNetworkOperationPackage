//
//  UrlRequest+Extension.swift
//  
//
//  Created by Emircan Aydın on 9.10.2021.
//


import Foundation

extension URLRequest {
    
    public var headers: HTTPHeaders {
        get { allHTTPHeaderFields.map(HTTPHeaders.init) ?? HTTPHeaders() }
        set { allHTTPHeaderFields = newValue.dictionary }
    }
}
