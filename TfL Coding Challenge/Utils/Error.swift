//
//  Error.swift
//  TfL Coding Challenge
//
//  Created by Nicolas Brucchieri on 03/03/2020.
//  Copyright © 2020 Nicolas Brucchieri. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case notFound(message: String)
    case parse
    case unknown
    
    public var errorDescription: String? {
       switch self {
       case .notFound(let message):
           return message
       default:
            return nil
       }
   }
}
