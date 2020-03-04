//
//  StatusViewModelTests.swift
//  TfL Coding ChallengeTests
//
//  Created by Nicolas Brucchieri on 04/03/2020.
//  Copyright © 2020 Nicolas Brucchieri. All rights reserved.
//

import XCTest
@testable import TfL_Coding_Challenge

fileprivate class MockRoadManager: RoadManagerProtocol {
    
    var result: Result<[RoadStatus], Error>?
    
    func getRoadStatus(text: String, completion: @escaping (Result<[RoadStatus], Error>) -> ()) {
        completion(result!)
    }
    
}

class StatusViewModelTests: XCTestCase {

    var viewModel: StatusViewModel!
    var rowStatus: [RoadStatus]!
    fileprivate var mockRoadManager: MockRoadManager!
    
    override func setUp() {
        super.setUp()
        mockRoadManager = MockRoadManager()
        rowStatus = [RoadStatus(id: "A1", displayName: "A-1", statusSeverity: "Good", statusSeverityDescription: "No delays")]
        viewModel = StatusViewModel(roadManager: mockRoadManager)
    }

    override func tearDown() {
        viewModel = nil
        mockRoadManager = nil
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertTrue(viewModel.tableViewStatusRow.value.count == 0)
        XCTAssertFalse(viewModel.isLoading.value)
        XCTAssertNil(viewModel.alert.value)
    }

    func testSearchNilText() {
        // Given
        let text: String? = nil
        viewModel.tableViewStatusRow.value = rowStatus
        
        // When
        viewModel.searchRoads(text: text)
        
        // Assert
        XCTAssertTrue(viewModel.tableViewStatusRow.value.count == 0)
        XCTAssertFalse(viewModel.isLoading.value)
        XCTAssertNil(viewModel.alert.value)
    }
    
    func testSearchEmptyText() {
        // Given
        let text: String? = ""
        viewModel.tableViewStatusRow.value = rowStatus
        
        // When
        viewModel.searchRoads(text: text)
        
        // Assert
        XCTAssertTrue(viewModel.tableViewStatusRow.value.count == 0)
        XCTAssertFalse(viewModel.isLoading.value)
        XCTAssertNil(viewModel.alert.value)
    }

    func testSearchNotFound() {
        // Given
        let searchText = "AA"
        let notFoundMessage = "Not found"
        mockRoadManager.result = .failure(CustomError.notFound(message: notFoundMessage))
        
        // When
        viewModel.searchRoads(text: searchText)
        
        // Assert
        XCTAssertTrue(viewModel.tableViewStatusRow.value.count == 0)
        XCTAssertFalse(viewModel.isLoading.value)
        XCTAssertNotNil(viewModel.alert.value)
        XCTAssertEqual(viewModel.alert.value?.title, "Error")
        XCTAssertEqual(viewModel.alert.value?.message, notFoundMessage)
        XCTAssertEqual(viewModel.alert.value?.button, "Accept")
    }
    
    func testSearchUnknownError() {
        // Given
        let searchText = "AA"
        let UnknownErrorMessage = "The operation couldn’t be completed. (TfL_Coding_Challenge.CustomError error 2.)"
        mockRoadManager.result = .failure(CustomError.unknown)
        
        // When
        viewModel.searchRoads(text: searchText)
        
        // Assert
        XCTAssertTrue(viewModel.tableViewStatusRow.value.count == 0)
        XCTAssertFalse(viewModel.isLoading.value)
        XCTAssertNotNil(viewModel.alert.value)
        XCTAssertEqual(viewModel.alert.value?.title, "Error")
        XCTAssertEqual(viewModel.alert.value?.message, UnknownErrorMessage)
        XCTAssertEqual(viewModel.alert.value?.button, "Accept")
    }
    
    func testSearchFound() {
        // Given
        let text = "A1"
        mockRoadManager.result = .success(rowStatus)
        
        // When
        viewModel.searchRoads(text: text)
        
        // Assert
        XCTAssertTrue(viewModel.tableViewStatusRow.value.count == 1)
        XCTAssertEqual(viewModel.tableViewStatusRow.value[0].displayName, rowStatus[0].displayName)
        XCTAssertEqual(viewModel.tableViewStatusRow.value[0].statusSeverity, rowStatus[0].statusSeverity)
        XCTAssertEqual(viewModel.tableViewStatusRow.value[0].statusSeverityDescription, rowStatus[0].statusSeverityDescription)
        XCTAssertFalse(viewModel.isLoading.value)
        XCTAssertNil(viewModel.alert.value)
    }
    
}
