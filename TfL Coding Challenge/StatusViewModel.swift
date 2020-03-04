//
//  StatusViewModel.swift
//  TfL Coding Challenge
//
//  Created by Nicolas Brucchieri on 04/03/2020.
//  Copyright © 2020 Nicolas Brucchieri. All rights reserved.
//

import Foundation

class StatusViewModel {
    
    let roadManager: RoadManagerProtocol

    let imputPlaceholder = "Find a road"
    let errorMessageTitle = "Error"
    let errorButtonText = "Accept"
    
    let tableViewStatusRow: Box<[RoadStatus]> = Box([])
    let isLoading: Box<Bool> = Box(false)
    var alert: Box<AlertModel?> = Box(nil)
    
    init(roadManager: RoadManagerProtocol = RoadManager.sharedInstance) {
        self.roadManager = roadManager
    }
    
    func searchRoads(text: String?) {
        tableViewStatusRow.value = []
        
        guard let text = text, !text.isEmpty else {
            return
        }
        
        isLoading.value = true
        roadManager.getRoadStatus(text: text) { [weak self] (result: Result<[RoadStatus], Error>) in
            self?.isLoading.value = false
            
            switch result {
            case .success(let data):
                self?.tableViewStatusRow.value = data
    
            case .failure(let error):
                guard let title = self?.errorMessageTitle,
                let errorButtonText = self?.errorButtonText else {
                    return
                }
                
                var description = error.localizedDescription
                if let error = error as? CustomError,
                    let errorDescription = error.errorDescription
                {
                    description = errorDescription
                }
    
                self?.alert.value = AlertModel(
                    title: title,
                    message: description,
                    button: errorButtonText
                )
                
            }
        }
    }
    
}
