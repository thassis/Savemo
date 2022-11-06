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
    
}
