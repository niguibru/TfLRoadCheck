//
//  Router.swift
//  TfL Coding Challenge
//
//  Created by Nicolas Brucchieri on 03/03/2020.
//  Copyright © 2020 Nicolas Brucchieri. All rights reserved.
//

import Foundation

enum RequestBuilder {
    
    var urlRequest: URLRequest? {
        get {
            guard let keys = InfoPlistHelper.getTFLKeys(),
                let appId = keys["appId"] as? String,
                let appKey = keys["appKey"] as? String
                else { return nil }
            
            var urlComponents = URLComponents()
            urlComponents.scheme = self.scheme
            urlComponents.host = self.host
            urlComponents.path = self.path
            urlComponents.queryItems = [
                URLQueryItem(name: "app_id", value: appId),
                URLQueryItem(name: "app_key", value: appKey)
            ]
            
            guard let url = urlComponents.url else { return nil }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = self.method

            return urlRequest
        }
    }
    
    case getRoadStatus(road: String)
  
    var method: String {
        switch self {
        case .getRoadStatus:
            return "GET"
        }
    }
    
    var scheme: String {
        switch self {
        case .getRoadStatus:
            return "https"
        }
    }
  
    var host: String {
        switch self {
        case .getRoadStatus:
            return "api.tfl.gov.uk"
        }
    }
  
    var path: String {
        switch self {
        case .getRoadStatus(let road):
            return "/Road/\(road)"
        }
    }
    
}

