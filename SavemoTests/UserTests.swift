//
//  UserTests.swift
//  SavemoTests
//
//  Created by Thiago Assis on 06/11/22.
//

import XCTest

final class UserTests: XCTestCase {

    var user: User!
    
    override func setUp() {
        user = User(operations: [], categories: [], balance: 0, salary: 0)
    }
    
    func testPositiveBalanceAfterAddingCredit() {
        let FIVE_REAIS = Float(5)
        let credit = try! Operation(FIVE_REAIS, OperationType.Credit, startDate: Date())
        
        user.addOperation(credit)
        XCTAssertEqual(user.balance, FIVE_REAIS)
    }
    
    func testNegativeBalanceAfterAddingDebit() {
        let FIVE_REAIS = Float(5)
        let credit = try! Operation(FIVE_REAIS, OperationType.Debit, startDate: Date())
        
        user.addOperation(credit)
        XCTAssertEqual(user.balance, FIVE_REAIS * -1)
    }
    
    func testLimitValueCategoryBeingExceeded() {
        
        XCTAssert(true)
    }

}
