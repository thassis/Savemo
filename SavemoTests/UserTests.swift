//
//  UserTests.swift
//  SavemoTests
//
//  Created by Thiago Assis on 06/11/22.
//

import XCTest

final class UserTests: XCTestCase {
    let operationCurrentDate = try! Operation(5, OperationType.Debit, startDate: Date())
    let operationLastYear = try! Operation(5, OperationType.Debit, startDate: Calendar.current.date(byAdding: .year, value: -1, to: Date())!)
    let foodCategory = try! Category(name: DefaultCategories.Food.rawValue, limitedValue: Float(60))

    var user: User!
    
    override func setUp() {
        user = User(operations: [operationCurrentDate, operationLastYear], categories: [foodCategory], balance: 0, salary: 2000)
    }
    
    func testPositiveBalanceAfterAddingCredit() {
        let FIVE_REAIS = Float(5)
        let credit = try! Operation(FIVE_REAIS, OperationType.Credit, startDate: Date())
        
        try! user.addOperation(credit)
        XCTAssertEqual(user.balance, FIVE_REAIS)
    }
    
    func testNegativeBalanceAfterAddingDebit() {
        let FIVE_REAIS = Float(5)
        let credit = try! Operation(FIVE_REAIS, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)
        
        try! user.addOperation(credit)
        XCTAssertEqual(user.balance, FIVE_REAIS * -1)
    }
    
    func testGetOperationsByCurrentMonthYear() {
        let date = Date()
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        let currentMonth = calendarDate.month!
        let currentYear = calendarDate.year!
        
        let operations = user.getOperationsByMonthYear(month: currentMonth, year: currentYear)
        
        XCTAssert(operations[0] == operationCurrentDate)
    }
    
    func testGetOperationsByLastMonthYear() {
        let date = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        let currentMonth = calendarDate.month!
        let lastYear = calendarDate.year!
        
        let operations = user.getOperationsByMonthYear(month: currentMonth, year: lastYear)
        
        XCTAssert(operations[0] == operationLastYear)
    }
    
    func testFoundNoOperationsByLastTwoYears() {
        let date = Calendar.current.date(byAdding: .year, value: -2, to: Date())!
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        let currentMonth = calendarDate.month!
        let lastYear = calendarDate.year!
        
        let operations = user.getOperationsByMonthYear(month: currentMonth, year: lastYear)
        
        XCTAssertEqual(operations.count, 0)
    }
    
    func testAddCategory() throws {
        let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: Float(200))
        try user.addCategory(educationCategory)
        XCTAssertEqual(user.categories[1], educationCategory)
    }
    
    func testCantAddCategoryIfValuesAreBiggerThanSalary() throws {
        let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: Float(20000))
        XCTAssertThrowsError(try user.addCategory(educationCategory)) { (error) in
            XCTAssertEqual(error as? UserError, UserError.categoryExceededLimitedValue)
        }
    }
    
    func testCannotAddRepeatedCategories(){
        let foodCategory = try! Category(name: DefaultCategories.Food.rawValue, limitedValue: Float(20000))
        XCTAssertThrowsError(try user.addCategory(foodCategory)) { (error) in
            XCTAssertEqual(error as? UserError, UserError.categoryAlreadyExists)
        }
    }
    
    func testGetFoodCategoryExceededLimitAfterAddingDebits() throws {
        let pizzaOperation = try! Operation(80, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)
        
        try! user.addOperation(pizzaOperation)
        let exceededCategories = user.getExceededCategories()
        XCTAssertEqual(exceededCategories[0], foodCategory)
    }
    
    func testGetManyCategoriesThatExceededLimitAfterAddingDebits() throws {
        let pizzaOperation = try! Operation(80, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)
        
        let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: Float(100))
        let booksOperation = try! Operation(120, OperationType.Debit, startDate: Date(), category: DefaultCategories.Education.rawValue)
        
        try user.addCategory(educationCategory)
        
        try! user.addOperation(pizzaOperation)
        try! user.addOperation(booksOperation)
        
        let exceededCategories = user.getExceededCategories()
        XCTAssertEqual(exceededCategories[0], foodCategory)
        XCTAssertEqual(exceededCategories[1], educationCategory)
    }
    
    func testGetNoCategoryExceeded() throws {
        let pizzaOperation = try! Operation(8, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)
                
        try! user.addOperation(pizzaOperation)
        try! user.addOperation(pizzaOperation)
        try! user.addOperation(pizzaOperation)
        
        let exceededCategories = user.getExceededCategories()
        XCTAssertEqual(exceededCategories, [])
    }
}
