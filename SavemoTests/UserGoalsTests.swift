//
//  CategoryTests.swift
//  SavemoTests
//
//  Created by Thiago Assis on 07/11/22.
//

import XCTest

final class UserGoalsTests: XCTestCase {
    
    func testGoalWasAdded() throws {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(500000)
        
        var userGoals = UserGoals()
        try userGoals.addGoal(name: GOAL_NAME, value: GOAL_VALUE)
        
        XCTAssertEqual(userGoals.goals.count, 1)
    }
    
    func testGoalWasEdited() throws {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(500000)
        let NEW_GOAL_NAME = "car"
        
        var userGoals = UserGoals()
        
        try userGoals.addGoal(name: GOAL_NAME, value: GOAL_VALUE)
        userGoals.editGoalByName(name: GOAL_NAME, newName: NEW_GOAL_NAME)
        
        XCTAssertEqual(userGoals.goals[0].name, NEW_GOAL_NAME)
    }
    
    func testThowErrorWhenAddGoalWithSameName() throws {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(500000)
        
        var userGoals = UserGoals()
        try userGoals.addGoal(name: GOAL_NAME, value: GOAL_VALUE)
        
        XCTAssertThrowsError(try userGoals.addGoal(name: GOAL_NAME, value: GOAL_VALUE)) { (error) in
            XCTAssertEqual(error as? GoalsError, GoalsError.nameAlreadyAdded)
        }
    }
    
    func testGoalWasRemoved() throws {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(500000)
        
        var userGoals = UserGoals()
        try userGoals.addGoal(name: GOAL_NAME, value: GOAL_VALUE)
        userGoals.removeGoal(name: GOAL_NAME)
        
        XCTAssertEqual(userGoals.goals.count, 0)
    }
    
    func testThrowErrorWhenAddGoalWithValueZero() {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(0)
        
        var userGoals = UserGoals()
        
        XCTAssertThrowsError(try userGoals.addGoal(name: GOAL_NAME, value: GOAL_VALUE)) { (error) in
            XCTAssertEqual(error as? ValueError, ValueError.isZero)
        }
    }
    
    func testTrueWhenGoalIsAchieved() throws {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(100)
        let FIFTY_REAIS = Float(50)
        
        var userGoals = UserGoals()
        
        try userGoals.addGoal(name: GOAL_NAME, value: GOAL_VALUE)
        userGoals.addValueToAchieveGoal(name: GOAL_NAME, value: FIFTY_REAIS)
        userGoals.addValueToAchieveGoal(name: GOAL_NAME, value: FIFTY_REAIS)
        
        XCTAssertTrue(userGoals.checkIsGoalAchieved(name: GOAL_NAME))
    }
    
    func testFalseWhenGoalIsNotAchieved() throws {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(100)
        let FIFTY_REAIS = Float(50)
        
        var userGoals = UserGoals()
        
        try userGoals.addGoal(name: GOAL_NAME, value: GOAL_VALUE)
        userGoals.addValueToAchieveGoal(name: GOAL_NAME, value: FIFTY_REAIS)
        
        XCTAssertFalse(userGoals.checkIsGoalAchieved(name: GOAL_NAME))
    }
    
    func testSuggestedValueYouNeedToAddEveryMonthToAchieveTheGoalInOneYear() throws {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(120)
        let VALUE_TO_ADD_EVERY_MONTH = Float(10)
        var userGoals = UserGoals()
        
        try userGoals.addGoal(name: GOAL_NAME, value: GOAL_VALUE)
        
        XCTAssertEqual(userGoals.goals[0].suggestedValueToAchieveInOneYear, VALUE_TO_ADD_EVERY_MONTH)
    }
    
    func testValueYouNeedToAddToAchieveGoal() throws {
        let GOAL_NAME = "house"
        let GOAL_VALUE = Float(120)
        let FIFTY_REAIS = Float(50)
        let VALUE_YOU_NEED_TO_ACHIEVE_GOAL = Float(70)
        
        var userGoals = UserGoals()
        try userGoals.addGoal(name: GOAL_NAME, value: GOAL_VALUE)
        userGoals.addValueToAchieveGoal(name: GOAL_NAME, value: FIFTY_REAIS)
        
        XCTAssertEqual(userGoals.goals[0].valueToAchieveGoal, VALUE_YOU_NEED_TO_ACHIEVE_GOAL)
    }
    
}
