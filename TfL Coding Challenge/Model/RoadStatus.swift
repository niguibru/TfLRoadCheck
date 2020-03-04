//
//  RoadStatusModel.swift
//  TfL Coding Challenge
//
//  Created by Nicolas Brucchieri on 03/03/2020.
//  Copyright © 2020 Nicolas Brucchieri. All rights reserved.
//

import UIKit

struct RoadStatus: Codable {
    let id: String
    let displayName: String
    let statusSeverity: String
    let statusSeverityDescription: String
    
    func colorForSeverity() -> UIColor {
        if statusSeverity == "Good" {
            return .statusGood
        } else {
            return .statusClosed
        }
    }
}
