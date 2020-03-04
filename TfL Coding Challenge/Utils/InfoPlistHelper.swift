//
//  InfoPlist.swift
//  TfL Coding Challenge
//
//  Created by Nicolas Brucchieri on 04/03/2020.
//  Copyright © 2020 Nicolas Brucchieri. All rights reserved.
//

import Foundation

struct InfoPlistHelper {
    
    static func getTFLKeys() -> [String: Any]? {
        var plistData: [String: Any] = [:]
        
        if  let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path)
        {
            do {
                plistData = try PropertyListSerialization.propertyList(
                    from: xml,
                    options: [],
                    format: nil
                ) as! [String : Any]
            }
            catch {
                print("Error fetching list file")
            }
        }

        return plistData["TFL Keys"] as? [String : Any]
    }
    
}
