//
//  OperationTests.swift
//  SavemoTests
//
//  Created by Thiago Assis on 06/11/22.
//

import XCTest

final class OperationTests: XCTestCase {
    
    func testOperationWasCreatedWithRightValue() throws {
        let FIVE_REAIS = Float(5.0)
        let operation = try! Operation(FIVE_REAIS, OperationType.Credit , startDate: Date())
        XCTAssertEqual(operation.value, FIVE_REAIS)
    }
    
    func testCreationOperationWithNoValue() {
        let ZERO_REAIS = Float(0)
        
        XCTAssertThrowsError(try Operation(ZERO_REAIS, OperationType.Debit, startDate: Date())) { (error) in
            XCTAssertEqual(error as? ValueError, ValueError.isZero)
        }
    }
    
    func testTwoOperationsAreEquals() {
        let FIVE_REAIS = Float(5.0)
        let date = Date()
        let firstOperation = try! Operation(FIVE_REAIS, OperationType.Credit , startDate: date)
        let secondOperation = try! Operation(FIVE_REAIS, OperationType.Credit , startDate: date)
        
        XCTAssert(firstOperation == secondOperation)
    }
    
    func testTwoOperationsAreNotEquals() {
        let FIVE_REAIS = Float(5.0)
        let SEVEN_REAIS = Float(7.0)
        let firstOperation = try! Operation(FIVE_REAIS, OperationType.Credit , startDate: Date())
        let secondOperation = try! Operation(SEVEN_REAIS, OperationType.Credit , startDate: Date())
        
        XCTAssertFalse(firstOperation == secondOperation)
    }
}
