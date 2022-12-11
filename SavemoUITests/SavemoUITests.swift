//
//  SavemoUITests.swift
//  SavemoUITests
//
//  Created by Thiago Assis on 30/10/22.
//

import XCTest

final class SavemoUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        XCUIDevice.shared.orientation = .portrait
        app.launchArguments = ["--Reset"]
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    
    func testBalanceValueAfterAddingCredit() throws {
     /*   let cell = app.tables.cells.firstMatch
                XCTAssertTrue(cell.waitForExistence(timeout: 10))
                cell.tap()*/
        
        let exposure = app.images["Exposure"]
        XCTAssertTrue(exposure.waitForExistence(timeout: 10))
        exposure.tap()
        
        let registerCredit = app.staticTexts["Register Credit"]
        XCTAssertTrue(registerCredit.waitForExistence(timeout: 10))
        registerCredit.tap()
        
        let inputValue = app.textFields["InputValue"]
        XCTAssertTrue(inputValue.waitForExistence(timeout: 10))
        inputValue.tap()
        
        sleep(2)
        let key = app.keys["4"]
        key.tap()
        sleep(2)
        let key2 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sleep(2)
        key2.tap()
        key2.tap()
        key2.tap()
        key2.tap()
        
        let create = app.buttons["Create"]
        XCTAssertTrue(create.waitForExistence(timeout: 10))
        create.tap()
        sleep(10)
        XCTAssert(app.staticTexts["R$ 20800.00"].waitForExistence(timeout: 10))
    }
    
    /*func testBalanceValueAfterAddingDebit() throws {
        
        app.images["Exposure"].tap()
        app.staticTexts["Register Debit"].tap()
        
        app.textFields["InputValue"].tap()
        let key = app.keys["4"]
        key.tap()
        let key2 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        key2.tap()
        key2.tap()
        app.buttons["Create"].tap()
        
        XCTAssert(app.staticTexts["R$ 20000.00"].exists)
    }
    
    func testCheckValueCanBeSpentAfterAddingDebit() throws {
        app.images["Exposure"].tap()
        app.staticTexts["Register Debit"].tap()
        app.textFields["InputValue"].tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        key2.tap()
        app.buttons["Create"].tap()
        
        XCTAssert(app.staticTexts["You can spend R$ 350.00 this month yet"].exists)
    }
    
    func testCheckValueCannotBeSpentAfterAddingBigDebit() throws {
        app.images["Exposure"].tap()
        app.staticTexts["Register Debit"].tap()
        app.textFields["InputValue"].tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        key2.tap()
        key2.tap()
        key2.tap()
        key2.tap()
        key2.tap()
        app.buttons["Create"].tap()
        
        XCTAssert(app.staticTexts["You've spent all the money you should this month"].exists)
    }
    
    func testCantAddOperationIfValueIsZero() throws {
        let starBalanceValue = "R$ 20400.00"
        
        app.images["Exposure"].tap()
        app.staticTexts["Register Debit"].tap()
        
        app.buttons["Create"].tap()
        
        XCTAssert(app.staticTexts["Please, enter a valid value"].exists)
        XCTAssert(app.staticTexts[starBalanceValue].exists)
        
    }*/
}
