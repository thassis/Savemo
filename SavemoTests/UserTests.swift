//
//  UserTests.swift
//  SavemoTests
//
//  Created by Thiago Assis on 06/11/22.
//

import XCTest

let FOOD_LIMITED_VALUE = Float(60)
let SALARY = Float(2000)

final class UserTests: XCTestCase {
    let operationCurrentDate = try! Operation(5, OperationType.Debit, startDate: Date())
    let operationLastYear = try! Operation(5, OperationType.Debit, startDate: Calendar.current.date(byAdding: .year, value: -1, to: Date())!)
    let foodCategory = try! Category(name: DefaultCategories.Food.rawValue, limitedValue: FOOD_LIMITED_VALUE)

    var user: User!
    
    override func setUp() {
        user = User(operations: [operationCurrentDate, operationLastYear], categories: [foodCategory], balance: 0, salary: SALARY)
    }
    
    func testPositiveBalanceAfterAddingCredit() {
        let FIVE_REAIS = Float(5)
        let credit = try! Operation(FIVE_REAIS, OperationType.Credit, startDate: Date())
        
        try! user.addOperation(credit)
        XCTAssertEqual(user.balance, FIVE_REAIS)
    }
    
    func testNegativeBalanceAfterAddingDebit() {
        let FIVE_REAIS = Float(5)
        let debit = try! Operation(FIVE_REAIS, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)
        
        try! user.addOperation(debit)
        XCTAssertEqual(user.balance, FIVE_REAIS * -1)
    }
    
    func testThrownErrorAfterAddingDebitWithNoCategory() {
        let FIVE_REAIS = Float(5)
        let debit = try! Operation(FIVE_REAIS, OperationType.Debit, startDate: Date())
        
        XCTAssertThrowsError(try user.addOperation(debit)) { (error) in
            XCTAssertEqual(error as? UserError, UserError.operationWithoutValidCategory)
        }
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
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let currentMonth = calendarDate.month!
        let currentYear = calendarDate.year!
        
        let pizzaOperation = try! Operation(80, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)
        
        try! user.addOperation(pizzaOperation)
        let exceededCategories = user.getExceededCategoriesByMonthYear(month: currentMonth, year: currentYear)
        XCTAssertEqual(exceededCategories[0], foodCategory)
    }
    
    func testGetManyCategoriesThatExceededLimitAfterAddingDebits() throws {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let currentMonth = calendarDate.month!
        let currentYear = calendarDate.year!
        
        let pizzaOperation = try! Operation(80, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)
        
        let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: Float(100))
        let booksOperation = try! Operation(120, OperationType.Debit, startDate: Date(), category: DefaultCategories.Education.rawValue)
        
        try user.addCategory(educationCategory)
        
        try! user.addOperation(pizzaOperation)
        try! user.addOperation(booksOperation)
        
        let exceededCategories = user.getExceededCategoriesByMonthYear(month: currentMonth, year: currentYear)
        XCTAssertEqual(exceededCategories[0], foodCategory)
        XCTAssertEqual(exceededCategories[1], educationCategory)
    }
    
    func testGetNoCategoryExceeded() throws {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let currentMonth = calendarDate.month!
        let currentYear = calendarDate.year!
        
        let pizzaOperation = try! Operation(8, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)
                
        try! user.addOperation(pizzaOperation)
        try! user.addOperation(pizzaOperation)
        try! user.addOperation(pizzaOperation)
        
        let exceededCategories = user.getExceededCategoriesByMonthYear(month: currentMonth, year: currentYear)
        XCTAssertEqual(exceededCategories, [])
    }
    
    func testTotalLimitedValueFromFoodCategory() {
        XCTAssertEqual(user.totalLimitedValueFromCategories, FOOD_LIMITED_VALUE)
    }
    
    func testTotalLimitedValueAfterAddingCategory() {
        let EDUCATION_LIMITED_VALUE = Float(200)
        try! user.addCategory(Category(name: "some category", limitedValue: EDUCATION_LIMITED_VALUE))
        XCTAssertEqual(user.totalLimitedValueFromCategories, EDUCATION_LIMITED_VALUE + FOOD_LIMITED_VALUE)
    }
    
    func testValueSpentByFoodCategory() {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let currentMonth = calendarDate.month!
        let currentYear = calendarDate.year!
        
        let PIZZA_VALUE = Float(80)
        let pizzaOperation = try! Operation(PIZZA_VALUE, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)

        try! user.addOperation(pizzaOperation)
        try! user.addOperation(pizzaOperation)
        
        let valueSpent = user.getValueHaveBeenSpentByCategory(foodCategory, month: currentMonth, year: currentYear)
        XCTAssertEqual(valueSpent, PIZZA_VALUE*2)
    }
    
    func testNoValueSpentByFoodCategoryWithWrongDate() {
        let date = Calendar.current.date(byAdding: .year, value: -2, to: Date())!
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        let currentMonth = calendarDate.month!
        let lastYear = calendarDate.year!
        
        let PIZZA_VALUE = Float(80)
        let pizzaOperation = try! Operation(PIZZA_VALUE, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)

        try! user.addOperation(pizzaOperation)
        try! user.addOperation(pizzaOperation)
        
        let valueSpent = user.getValueHaveBeenSpentByCategory(foodCategory, month: currentMonth, year: lastYear)
        XCTAssertEqual(valueSpent, 0)
    }
    
    func testValueCanBeSpentByFoodCategory() {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let currentMonth = calendarDate.month!
        let currentYear = calendarDate.year!
        
        let PIZZA_VALUE = Float(8)
        let pizzaOperation = try! Operation(PIZZA_VALUE, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)

        try! user.addOperation(pizzaOperation)
        try! user.addOperation(pizzaOperation)
        
        let VALUE_CAN_BE_SPENT = FOOD_LIMITED_VALUE - (PIZZA_VALUE*2)
        
        let valueCanBeSpent = user.getValueCanBeSpentByCategory(foodCategory, month: currentMonth, year: currentYear)
        XCTAssertEqual(valueCanBeSpent, VALUE_CAN_BE_SPENT)
    }
    
    func testValueCanBeSpentIsZeroWhenNegative() {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let currentMonth = calendarDate.month!
        let currentYear = calendarDate.year!
        
        let PIZZA_VALUE = Float(80)
        let pizzaOperation = try! Operation(PIZZA_VALUE, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)

        try! user.addOperation(pizzaOperation)
        try! user.addOperation(pizzaOperation)
        
        let VALUE_CAN_BE_SPENT = Float(0)
        
        let valueCanBeSpent = user.getValueCanBeSpentByCategory(foodCategory, month: currentMonth, year: currentYear)
        XCTAssertEqual(valueCanBeSpent, VALUE_CAN_BE_SPENT)
    }
    
    func testValueCanBeSpentIsZeroWhenIsReallyZero() {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let currentMonth = calendarDate.month!
        let currentYear = calendarDate.year!
        
        let PIZZA_VALUE = Float(60)
        let pizzaOperation = try! Operation(PIZZA_VALUE, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)

        try! user.addOperation(pizzaOperation)
        try! user.addOperation(pizzaOperation)
        
        let VALUE_CAN_BE_SPENT = Float(0)
        
        let valueCanBeSpent = user.getValueCanBeSpentByCategory(foodCategory, month: currentMonth, year: currentYear)
        XCTAssertEqual(valueCanBeSpent, VALUE_CAN_BE_SPENT)
    }
    
    func testPositiveTotalValueCanBeSpentWithAllCategories() {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let currentMonth = calendarDate.month!
        let currentYear = calendarDate.year!
        
        let PIZZA_VALUE = Float(60)
        let pizzaOperation = try! Operation(PIZZA_VALUE, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)

        try! user.addOperation(pizzaOperation)
        try! user.addOperation(pizzaOperation)
        
        let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: Float(100))
        try! user.addCategory(educationCategory)
        
        let BOOK_VALUE = Float(60)
        let booksOperation = try! Operation(BOOK_VALUE, OperationType.Debit, startDate: Date(), category: DefaultCategories.Education.rawValue)
        
        try! user.addOperation(pizzaOperation)
        try! user.addOperation(booksOperation)
        
        let expectedTotalValueCanBeSpent = SALARY - (PIZZA_VALUE*2) - (BOOK_VALUE*2)
        let totalValueCanBeSpent = user.getValueCanBeSpentAllCategories(month: currentMonth, year: currentYear)
        XCTAssertEqual(totalValueCanBeSpent, expectedTotalValueCanBeSpent)
    }
    
    func testTotalValueIsZeroWhenCanBeSpentWithAllCategoriesIsNegative() {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let currentMonth = calendarDate.month!
        let currentYear = calendarDate.year!
        
        let PIZZA_VALUE = Float(600)
        let pizzaOperation = try! Operation(PIZZA_VALUE, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)

        try! user.addOperation(pizzaOperation)
        try! user.addOperation(pizzaOperation)
        
        let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: Float(100))
        try! user.addCategory(educationCategory)
        
        let BOOK_VALUE = Float(600)
        let booksOperation = try! Operation(BOOK_VALUE, OperationType.Debit, startDate: Date(), category: DefaultCategories.Education.rawValue)
        
        try! user.addOperation(pizzaOperation)
        try! user.addOperation(booksOperation)
        
        let expectedTotalValueCanBeSpent = Float(0)
        let totalValueCanBeSpent = user.getValueCanBeSpentAllCategories(month: currentMonth, year: currentYear)
        XCTAssertEqual(totalValueCanBeSpent, expectedTotalValueCanBeSpent)
    }
    
    func testTotalValueIsZeroWhenCanBeSpentWithAllCategoriesIsReallyZero() {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let currentMonth = calendarDate.month!
        let currentYear = calendarDate.year!
        
        let PIZZA_VALUE = Float(500)
        let pizzaOperation = try! Operation(PIZZA_VALUE, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue)

        try! user.addOperation(pizzaOperation)
        try! user.addOperation(pizzaOperation)
        
        let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: Float(100))
        try! user.addCategory(educationCategory)
        
        let BOOK_VALUE = Float(500)
        let booksOperation = try! Operation(BOOK_VALUE, OperationType.Debit, startDate: Date(), category: DefaultCategories.Education.rawValue)
        
        try! user.addOperation(pizzaOperation)
        try! user.addOperation(booksOperation)
        
        let expectedTotalValueCanBeSpent = Float(0)
        let totalValueCanBeSpent = user.getValueCanBeSpentAllCategories(month: currentMonth, year: currentYear)
        XCTAssertEqual(totalValueCanBeSpent, expectedTotalValueCanBeSpent)
    }
}
