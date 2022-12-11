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
        app.images["Exposure"].tap()
        app.staticTexts["Register Credit"].tap()
        app.textFields["InputValue"].tap()
        let key = app/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        key2.tap()
        app.buttons["Create"].tap()
        
        XCTAssert(app.staticTexts["Total: R$ 20450.00"].exists)
    }
    
    func testBalanceValueAfterAddingDebit() throws {
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
        
        XCTAssert(app.staticTexts["Total: R$ 20350.00"].exists)
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
        app.images["Exposure"].tap()
        app.staticTexts["Register Debit"].tap()
        
        app.buttons["Create"].tap()
        
        XCTAssert(app.staticTexts["Please, enter a valid value"].exists)
        
    }
}
