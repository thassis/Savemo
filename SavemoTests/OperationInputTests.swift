//
//  OperationTests.swift
//  SavemoTests
//
//  Created by Thiago Assis on 07/11/22.
//

import XCTest

final class OperationInputTests: XCTestCase {
    
    func testValueInputIsValidWithOnlyNumber() {
        let VALUE_ONLY_NUMBERS = "5000"
        let isValid = OperationInput.validateValue(VALUE_ONLY_NUMBERS)
        XCTAssertTrue(isValid)
    }
    
    func testValueInputNotValidWithNumberAndLetters() {
        let VALUE_LETTERS_AND_NUMBERS = "tes5000te"
        let isValid = OperationInput.validateValue(VALUE_LETTERS_AND_NUMBERS)
        XCTAssertFalse(isValid)
    }
    
    func testValueInputNotValidWithEmptyString() {
        let isValid = OperationInput.validateValue("")
        XCTAssertFalse(isValid)
    }
    
    func testDateInputIsValidWithRightFormart() {
        let DATE_RIGHT_FORMATTED = "2022-07-11"
        let isValid = OperationInput.validateDate(DATE_RIGHT_FORMATTED)
        XCTAssertTrue(isValid)
    }
    
    func testDateInputNotValidWithWrongFormat() {
        let DATE_WRONG_FORMATTED = "2022-07-11 14:00"
        let isValid = OperationInput.validateDate(DATE_WRONG_FORMATTED)
        XCTAssertFalse(isValid)
    }
    
    func testDateInputNotValidWithEmptyString() {
        let isValid = OperationInput.validateDate("")
        XCTAssertFalse(isValid)
    }
    
    func testCategoryInputIsNotValidWithExistingCategory() {
        let CATEGORY_NAME = DefaultCategories.Food.rawValue
        
        let foodCategory = try! Category(name: DefaultCategories.Food.rawValue, limitedValue: Float(60))
        let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: Float(60))
        
        let isValid = OperationInput.validateCategory([foodCategory, educationCategory], CATEGORY_NAME)
        XCTAssertFalse(isValid)
    }
    
    func testCategoryInputIsValidWithUnknowCategory() {
        let CATEGORY_NAME = "unknow"
        
        let foodCategory = try! Category(name: DefaultCategories.Food.rawValue, limitedValue: Float(60))
        let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: Float(60))
        
        let isValid = OperationInput.validateCategory([foodCategory, educationCategory], CATEGORY_NAME)
        XCTAssertTrue(isValid)
    }
    
    func testCategoryInputNotValidWithEmptyString() {
        let CATEGORY_NAME = ""
        let foodCategory = try! Category(name: DefaultCategories.Food.rawValue, limitedValue: Float(60))
        let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: Float(60))
        
        let isValid = OperationInput.validateCategory([foodCategory, educationCategory], CATEGORY_NAME)
        XCTAssertFalse(isValid)
    }
}
