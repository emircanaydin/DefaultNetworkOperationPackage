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
    private let session: URLSession

    // Mark: - JsonDecoder -
    private var jsonDecoder = JSONDecoder()
    
    public init() {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 300
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        self.session = URLSession(configuration: config)
    }
    
    public func executeRequest<R>(urlRequest: URLRequest, completion: @escaping (Result<R, ErrorResponse>) -> Void) where R : Codable {
        
        session.dataTask(with: urlRequest) { [weak self](data, urlResponse, error) in
            self?.dataTaskHandler(data, urlResponse, error, completion: completion)
        }.resume()
        
    }
    
    private func dataTaskHandler<R: Codable>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<R, ErrorResponse>) -> Void) {
        
        if error != nil {
            print("error : \(String(describing: error))")
            completion(.failure(error as! ErrorResponse))
        }
        
        if let data = data {
            
            do {
                let dataDecoded = try jsonDecoder.decode(R.self, from: data)
                print("data : \(data)")
                completion(.success(dataDecoded))
            } catch let error {
                completion(.failure(error as! ErrorResponse))
                print("error :\(error)")
            }
        }
        
    }
    
    deinit {
        print("DEINIT APIMANAGER")
    }
    
}
