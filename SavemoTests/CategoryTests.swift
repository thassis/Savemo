//
//  CategoryTests.swift
//  SavemoTests
//
//  Created by Thiago Assis on 06/11/22.
//

import XCTest

final class CategoryTests: XCTestCase {
    
    func testCategoryWasCreatedWithDefaultName() {
        let LIMITED_VALUE = Float(100)
        let category = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: LIMITED_VALUE)
        XCTAssertEqual(DefaultCategories.Education.rawValue, category.name)
    }
    
    func testCategoryWasCreatedWithNotDefaultName() {
        let LIMITED_VALUE = Float(100)
        let RANDOM_NAME = "some random name"
        
        let category = try! Category(name: RANDOM_NAME, limitedValue: LIMITED_VALUE)
        
        XCTAssertEqual(RANDOM_NAME, category.name)
    }
    
    func testCreateCategoryWithLimitedValueAsZero() {
        let ZERO_REAIS = Float(0)
        
        XCTAssertThrowsError(try Category(name: DefaultCategories.Education.rawValue, limitedValue: ZERO_REAIS)) { (error) in
            XCTAssertEqual(error as? ValueError, ValueError.isZero)
        }
    }
    
    func testCategoryNameWasEditedWhitSuccess() {
        let LIMITED_VALUE = Float(100)
        let RANDOM_NAME = "some random name"
        let NEW_NAME = "some new name"

        let category = try! Category(name: RANDOM_NAME, limitedValue: LIMITED_VALUE)
        category.edit(name: NEW_NAME)

        XCTAssertEqual(category.name, NEW_NAME)
    }

    func testCategoryValueWasEditedWhitSuccess() {
        let LIMITED_VALUE = Float(100)
        let RANDOM_NAME = "some random name"
        let NEW_VALUE = Float(50)

        let category = try! Category(name: RANDOM_NAME, limitedValue: LIMITED_VALUE)
        category.edit(value: NEW_VALUE)
        
        XCTAssertEqual(category.value, NEW_VALUE)
    }

    func testCategoryWasNotEditedWhenNewLimitedValueIsZero() {
        let LIMITED_VALUE = Float(100)
        let RANDOM_NAME = "some random name"
        let NEW_VALUE = Float(0)

        let category = try! Category(name: RANDOM_NAME, limitedValue: LIMITED_VALUE)
        
        XCTAssertThrowsError(try category.edit(value: NEW_VALUE)) { (error) in
            XCTAssertEqual(error as? ValueError, ValueError.isZero)
        }
    }

    func testCategoryWasNotEditedWhenNameIsEmptyString() {
        let LIMITED_VALUE = Float(100)
        let RANDOM_NAME = "some random name"
        let NEW_NAME = ""

        let category = try! Category(name: RANDOM_NAME, limitedValue: LIMITED_VALUE)
        
        XCTAssertThrowsError(try category.edit(name: NEW_NAME)) { (error) in
            XCTAssertEqual(error as? CategoryError, CategoryError.nameCannotBeZero)
        }
    }
}
