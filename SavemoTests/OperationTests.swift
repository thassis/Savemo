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
    
    /*func testHasToPayAutomaticDebit() {
        let FIVE_REAIS = Float(5.0)
        
        var dateComponent = DateComponents()
        dateComponent.day = 1
        
        
        
        let operation = try! Operation(FIVE_REAIS, category: "some operation", startDate: Date(), automaticDebit: true, periodicity: Periodicity.daily)
        
        
    }*/
}
