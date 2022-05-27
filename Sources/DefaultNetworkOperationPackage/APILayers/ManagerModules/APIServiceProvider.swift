//
//  APIServiceProvider.swift
//  CartCodeCase
//
//  Created by Emircan Aydın on 9.10.2021.
//

import Foundation

open class ApiServiceProvider<T: Codable>: URLRequestProtocol {

    private var method: HTTPMethod
    private var baseUrl: String
    private var path: String?
    private var data: T?
    
    public init(method: HTTPMethod = .get,
         baseUrl: String,
         path: String? = nil,
         data: T? = nil) {
        
        self.method = method
        self.baseUrl = baseUrl
        self.path = path
        self.data = data
    }
    
    public func returnUrlRequest() throws -> URLRequest {
        
        var url = try baseUrl.asURL()
        
        if let path = path {
            url = url.appendingPathComponent(path)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        var headers = headers
        headers.add(HTTPHeader(name: HTTPHeaderFields.contentType.value.0, value: HTTPHeaderFields.contentType.value.1))
        request.headers = headers
        
        try configureEncoding(request: &request)
        
        return request
    }
    
    private func configureEncoding(request: inout URLRequest) throws {
        switch method {
        case .post, .put:
            try ParameterEncoding.jsonEncoding.encode(urlRequest: &request, parameters: params)
        case .get:
            try ParameterEncoding.urlEncoding.encode(urlRequest: &request, parameters: params)
        default:
            try ParameterEncoding.urlEncoding.encode(urlRequest: &request, parameters: params)
        }
    }
    
    private var params: Parameters? {
        return data.asDictionary()
    }

    public var headers: HTTPHeaders = HTTPHeaders()
}
