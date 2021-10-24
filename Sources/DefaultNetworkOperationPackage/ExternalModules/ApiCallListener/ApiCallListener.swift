//
//  File.swift
//  
//
//  Created by DarkBringer on 24.10.2021.
//

import Foundation

public protocol ApiCallListener {
    
    func onPreExecute()
    
    func onPostExecute()
    
}
