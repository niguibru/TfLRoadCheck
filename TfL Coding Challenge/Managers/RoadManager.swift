//
//  RoadManager.swift
//  TfL Coding Challenge
//
//  Created by Nicolas Brucchieri on 03/03/2020.
//  Copyright © 2020 Nicolas Brucchieri. All rights reserved.
//

import Foundation

protocol RoadManagerProtocol {
    func getRoadStatus(text: String, completion: @escaping (Result<[RoadStatus], Error>) -> ())
}

struct RoadManager: RoadManagerProtocol {
    
    static let sharedInstance = RoadManager()
    
    func getRoadStatus(text: String, completion: @escaping (Result<[RoadStatus], Error>) -> ()) {
        let request = RequestBuilder.getRoadStatus(road: text)
        return ServiceLayer.request(router: request, completion: completion)
    }
    
}
