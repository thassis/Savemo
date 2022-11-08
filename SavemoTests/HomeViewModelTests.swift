//
//  HomeViewModelTests.swift
//  SavemoTests
//
//  Created by Thiago Assis on 06/11/22.
//

import XCTest

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    
    override func setUpWithError() throws {
        viewModel = HomeViewModel()
    }
    
    func testCreditAddedCorrectly() {
        try! viewModel.addOperation("10", "", "date", "some category", type: OperationType.Credit)
        try! viewModel.addOperation("10", "", "date", "some category", type: OperationType.Credit)
        try! viewModel.addOperation("10", "", "date", "some category", type: OperationType.Credit)
        
        XCTAssertEqual(viewModel.user.operations.count, 7) //6 because there are already 4 added by default
    }
    
    func testDebitAddedCorrectly() {
        try! viewModel.addOperation("10", "", "date", "some category", type: OperationType.Debit)
        try! viewModel.addOperation("10", "", "date", "some category", type: OperationType.Debit)
        try! viewModel.addOperation("10", "", "date", "some category", type: OperationType.Debit)
        
        XCTAssertEqual(viewModel.user.operations.count, 7) //6 because there are already 4 added by default
    }
    
    func testDebitRaiseErrorWhenAddDebitValueZero() {
        XCTAssertThrowsError(try viewModel.addOperation("0", "", "date", "some category", type: OperationType.Debit)) { (error) in
            XCTAssertEqual(error as? ValueError, ValueError.isZero)
        }
    }
    
    func testDebitRaiseErrorWhenAddDebitValueIsEmptyString() {
        XCTAssertThrowsError(try viewModel.addOperation("", "", "date", "some category", type: OperationType.Debit)) { (error) in
            XCTAssertEqual(error as? ValueError, ValueError.isZero)
        }
    }
    
    func testDebitRaiseErrorWhenAddCreditValueZero() {
        XCTAssertThrowsError(try viewModel.addOperation("0", "", "date", "some category", type: OperationType.Credit)) { (error) in
            XCTAssertEqual(error as? ValueError, ValueError.isZero)
        }
    }
    
    func testDebitRaiseErrorWhenAddCreditValueIsEmptyString() {
        XCTAssertThrowsError(try viewModel.addOperation("", "", "date", "some category", type: OperationType.Credit)) { (error) in
            XCTAssertEqual(error as? ValueError, ValueError.isZero)
        }
    }
    
}
