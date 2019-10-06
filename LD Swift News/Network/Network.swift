//
//  Network.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 04/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation
import Moya

struct Network {
    typealias DecodingData<T> = (type: T.Type, decoder: JSONDecoder)
    static var provider = MoyaProvider<API>()
    
    static func request(
        _ target: API,
        success successCallback: @escaping () -> Void,
        error errorCallback: @escaping (_ statusCode: HTTPStatusCode) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void,
        completion completionCallback: @escaping () -> Void) -> Cancellable {
        
        let cancellableRequest = provider.request(target, callbackQueue: nil, progress: { _ in
        }, completion: { result in
            completionCallback()
            switch result {
            case let .success(response):
                let statusCode = HTTPStatusCode(rawValue: response.statusCode) ?? HTTPStatusCode.ok
                if statusCode.isSuccess {
                    successCallback()
                }
                else {
                    errorCallback(statusCode)
                }
            case let .failure(error):
                failureCallback(error)
            }
        })
        
        return cancellableRequest
    }
    
    @discardableResult
    static func request<T>(
        _ target: API,
        decodeType type: T.Type,
        decoder: JSONDecoder = JSONDecoder(),
        dispatchQueue: DispatchQueue? = nil,
        success successCallback: @escaping (_ data: T) -> Void,
        error errorCallback: @escaping (_ message: String) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void,
        completion completionCallback: @escaping () -> Void) -> Cancellable where T: Decodable {
        
        let cancellableRequest = provider.request(target) { result in
            completionCallback()
            switch result {
            case let .success(response):
                let statusCode = HTTPStatusCode(rawValue: response.statusCode) ?? HTTPStatusCode.ok
                
                if !statusCode.isSuccess {
                    let string = try? response.mapString()
                    let message = string ?? "no string error"
                    errorCallback(message)
                    return
                }
                do {
                    let result = try decoder.decode(T.self, from: response.data)
                    successCallback(result)
                }
                catch let e {
                    print(e)
                    errorCallback("Parsing error")
                }
            case let .failure(error):
                failureCallback(error)
            }
        }
        
        return cancellableRequest
    }
}
