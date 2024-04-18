//
//  NewMockDataService_Tests.swift
//  UnitTestAppTests
//
//  Created by Zuber Rehmani on 02/04/24.
//

import XCTest
@testable import UnitTestApp
import Combine

final class NewMockDataService_Tests: XCTestCase {
    
    var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellable.removeAll()
    }
    
    func test_NewMockDataService_init_doesSetupValuesCorrectly() {
        // Given
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString]
        
        // When
        let dataService = NewMockDataService(items: items)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)
        
        // Then
        XCTAssertFalse(dataService.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
    
    func test_NewMockDataService_downloadItemsWithEscaping_doesRetrunValues() {
        // Given
        var items: [String] = []
        let dataService = NewMockDataService(items: nil)
        
        // When
        let expectation = XCTestExpectation()
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(dataService.items.count, items.count)
        
    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesRetrunValues() {
        // Given
        var items: [String] = []
        let dataService = NewMockDataService(items: nil)
        
        // When
        let expectation = XCTestExpectation()
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail()
                }
            } receiveValue: { returnItems in
                items = returnItems
            }
            .store(in: &cancellable)

        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(dataService.items.count, items.count)
        
    }
    
    func test_NewMockDataService_downloadItemsWithCombine_doesFail() {
        // Given
        var items: [String] = []
        let dataService = NewMockDataService(items: [])
        
        // When
        let expectation = XCTestExpectation()
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail()
                    
                case .failure:
                    expectation.fulfill()
                }
            } receiveValue: { returnItems in
                items = returnItems
            }
            .store(in: &cancellable)

        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(dataService.items.count, items.count)
        
    }

}
