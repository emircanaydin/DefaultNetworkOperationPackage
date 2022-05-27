//
//  APIManager.swift
//  CartCodeCase
//
//  Created by Emircan Aydın on 9.10.2021.
//

import Foundation
import Network

public class APIManager: APIManagerInterface {
    
    public static let shared = APIManager()

    // Mark: - Session -
    private var session: URLSession

    // Mark: - JsonDecoder -
    private var jsonDecoder = JSONDecoder()
    
    private var apiCallListener: ApiCallListener?

    
    public init(apiCallListener: ApiCallListener? = nil) {
        self.apiCallListener = apiCallListener
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 300
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        self.session = URLSession(configuration: config)
    }
    
    public func executeRequest<R>(urlRequest: URLRequest, completion: @escaping (Result<R, ErrorResponse>) -> Void) where R : Codable {
        
        apiCallListener?.onPreExecute()
        
        session.dataTask(with: urlRequest) { [weak self](data, urlResponse, error) in
            self?.dataTaskHandler(data, urlResponse, error, completion: completion)
        }.resume()
        
    }
    
    private func dataTaskHandler<R: Codable>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<R, ErrorResponse>) -> Void) {
        
        if error != nil {
            print("error : \(String(describing: error))")
            completion(.failure(ErrorResponse(serverResponse: ServerResponse(returnMessage: error!.localizedDescription, returnCode: error!._code), apiConnectionErrorType: .serverError(error!._code))))
        }
        
        if let data = data {
            
            do {
                print("data: \(String(data: data, encoding: .utf8))")
                let dataDecoded = try jsonDecoder.decode(R.self, from: data)
                completion(.success(dataDecoded))
            } catch let error {
                let errorResponse = ErrorResponse(serverResponse: ServerResponse(returnMessage: error.localizedDescription, returnCode: error._code), apiConnectionErrorType: .dataDecodedFailed(error.localizedDescription))
                print("error :\(error)")
                completion(.failure(errorResponse))
            }
        }
        apiCallListener?.onPostExecute()
    }
    
    deinit {
        print("DEINIT APIMANAGER")
    }
    
}
