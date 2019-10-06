//
//  API.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 04/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum API {
    case fetchNews
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.reddit.com/r/")!
    }
    
    var path: String {
        switch self {
        case .fetchNews:
            return "swift/.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchNews:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var parameters: [String: String]? {
        switch self {
        case .fetchNews:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        switch self {
        case .fetchNews:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

private extension String {
    var utf8Encoded: Data { return data(using: .utf8)! }
}
