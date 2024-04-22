//
//  ContentViewModel_Tests.swift
//  UnitTestAppTests
//
//  Created by Zuber Rehmani on 26/03/24.
//

import XCTest
import Combine
@testable import UnitTestApp

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Testing Structure: Given, When, Then

final class ContentViewModel_Tests: XCTestCase {
    var viewModel: ContentViewModel?
    var cancellable = Set<AnyCancellable>()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ContentViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        cancellable.removeAll()
    }

    func test_ContentViewModel_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true
        
        // When
        let vm = ContentViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_ContentViewModel_isPremium_shouldBeFalse() {
        // Given
        let userIsPremium: Bool = false
        
        // When
        let vm = ContentViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertFalse(vm.isPremium)
    }

    func test_ContentViewModel_isPremium_shouldBeInjectedValue() {
        // Given
        let userIsPremium: Bool = Bool.random()
        // When
        let vm = ContentViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_ContentViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // When
            let vm = ContentViewModel(isPremium: userIsPremium)
            
            // Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    func test_ContentViewModel_dataArray_shouldBeEmpty() {
        
        // Given
//        let userIsPremium: Bool = Bool.random()
        
        // When
//        let vm = ContentViewModel(isPremium: userIsPremium)
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_ContentViewModel_dataArray_shouldAddSingleItem() {
        
        // Given
//        let vm = ContentViewModel(isPremium: Bool.random())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        vm.addItem(item: "hello")
        
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 1)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_ContentViewModel_dataArray_shouldAddItems() {
        
        // Given
//        let vm = ContentViewModel(isPremium: Bool.random())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let loopCount = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_ContentViewModel_dataArray_shouldAddBlankString() {
        
        // Given
//        let vm = ContentViewModel(isPremium: Bool.random())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        vm.addItem(item: "")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertFalse(!vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
        XCTAssertNotEqual(vm.dataArray.count, 1)
        XCTAssertLessThan(vm.dataArray.count, 1)
    }
    
    func test_ContentViewModel_selectedItem_shouldStartAsNil() {
        // Given
        
        // When
//        let vm = ContentViewModel(isPremium: Bool.random())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // Then
        XCTAssertNil(vm.selectedItem)
        XCTAssertTrue(vm.selectedItem == nil)
    }
    
    func test_ContentViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
//        let vm = ContentViewModel(isPremium: Bool.random())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        // select valid item
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // invalid item
        vm.selectItem(item: UUID().uuidString)
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_ContentViewModel_selectedItem_shouldBeSelected() {
        // Given
//        let vm = ContentViewModel(isPremium: Bool.random())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_ContentViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
//        let vm = ContentViewModel(isPremium: Bool.random())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_ContentViewModel_saveItem_shouldThrowError_itemNotFound() {
        // Given
//        let vm = ContentViewModel(isPremium: Bool.random())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw item not found error") { error in
            let returnedError = error as? ContentViewModel.DataError
            XCTAssertEqual(returnedError, ContentViewModel.DataError.itemNotFound)
        }
    }
    
    func test_ContentViewModel_saveItem_shouldThrowError_noData() {
        // Given
//        let vm = ContentViewModel(isPremium: Bool.random())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let returnedError = error as? ContentViewModel.DataError
            XCTAssertEqual(returnedError, ContentViewModel.DataError.noData)
        }
    }
    
    func test_ContentViewModel_saveItem_shouldSaveItem() {
        // Given
//        let vm = ContentViewModel(isPremium: Bool.random())
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        // Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }
    
    
    func test_ContentViewModel_downloadWithEscaping_shouldReturnItems() {
        // Given
        let vm = ContentViewModel(isPremium: Bool.random())
       
        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        vm.downloadWithEscaping()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_ContentViewModel_downloadWithCombine_shouldReturnItems() {
        // Given
        let vm = ContentViewModel(isPremium: Bool.random())
       
        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        vm.downloadWithCombine()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
}
