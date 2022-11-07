//
//  CategoryTests.swift
//  SavemoTests
//
//  Created by Thiago Assis on 07/11/22.
//

import XCTest

final class CategoryTests: XCTestCase {
    
    func testGoalWasAdded() {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(500000) 

        let goals = Goals()
        goals.add(name: GOAL_NAME, value: GOAL_VALUE)

        XCTAssertEqual(goals.count, 1)
    }

    func testGoalWasEdited() {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(500000) 
        let NEW_GOAL_NAME = "car"

        let goals = Goals()
        goals.add(name: GOAL_NAME, value: GOAL_VALUE)

        goals.edit(newName: NEW_GOAL_NAME)

        XCTAssertEqual(goals[0], NEW_GOAL_NAME)
    }

    func testThowErrorWhenAddGoalWithSameName() {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(500000) 

        let goals = Goals()
        goals.add(name: GOAL_NAME, value: GOAL_VALUE)

        XCTAssertThrowsError(try goals.add(name: GOAL_NAME, value: GOAL_VALUE)) { (error) in
            XCTAssertEqual(error as? GoalsError, GoalsError.nameAlreadyAdded)
        }
    }

    func testGoalWasRemoved() {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(500000) 

        let goals = Goals()
        goals.add(name: GOAL_NAME, value: GOAL_VALUE)
        goals.remove(GOAL_NAME)

        XCTAssertEqual(goals.count, 0)
    }

    func testThrowErrorWhenAddGoalWithValueZero() {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(0) 

        let goals = Goals()

        XCTAssertThrowsError(try goals.add(name: GOAL_NAME, value: GOAL_VALUE)) { (error) in
            XCTAssertEqual(error as? ValueError, ValueError.isZero)
        }
    }

    func testTrueWhenGoalIsAchieved() {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(100)
        let FIFTY_REAIS = Float(50) 

        let goals = Goals()
        
        goals.add(name: GOAL_NAME, value: GOAL_VALUE)
        goals.addValueToAchieveGoal(FIFTY_REAIS)
        goals.addValueToAchieveGoal(FIFTY_REAIS)

        XCTAssertTrue(goals.isGoalAchieved)
    }

    func testFalseWhenGoalIsNotAchieved() {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(100)
        let FIFTY_REAIS = Float(50) 

        let goals = Goals()
        
        goals.add(name: GOAL_NAME, value: GOAL_VALUE)
        goals.addValueToAchieveGoal(FIFTY_REAIS)

        XCTAssertFalse(goals.isGoalAchieved)
    }

    func testSuggestedValueYouNeedToAddEveryMonthToAchieveTheGoalInOneYear() {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(120)
        let FIFTY_REAIS = Float(50) 
        let VALUE_TO_ADD_EVERY_MONTH = 10
        let goals = Goals()
        
        goals.add(name: GOAL_NAME, value: GOAL_VALUE)

        XCTAssertEqual(goals[0].suggestedValueEveryMonth, VALUE_TO_ADD_EVERY_MONTH)
    }

    func testValueYouNeedToAddToAchieveGoal() {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(120)
        let FIFTY_REAIS = Float(50) 
        let VALUE_YOU_NEED_TO_ACHIEVE_GOAL = 70

        let goals = Goals()
        goals.add(name: GOAL_NAME, value: GOAL_VALUE)

        XCTAssertEqual(goals[0].valueToAchieveGoal, VALUE_YOU_NEED_TO_ACHIEVE_GOAL)
    }
    
}
