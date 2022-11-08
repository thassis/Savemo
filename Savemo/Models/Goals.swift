//
//  Goals.swift
//  Savemo
//
//  Created by Thiago Assis on 07/11/22.
//

import Foundation

struct Goal {
    private(set) var name: String
    private(set) var value: Float
    private(set) var savedValue: Float
    
    var valueToAchieveGoal: Float {
        let value = value - savedValue
        if(value < 0) { return Float(0) }
        return value
    }
    
    var suggestedValueToAchieveInOneYear: Float {
        value / 12
    }
    
    init(name: String, value: Float, savedValue: Float = 0) {
        self.name = name
        self.value = value
        self.savedValue = savedValue
    }
}

struct UserGoals {
    var goals: [Goal] = []
    
    mutating func addGoal(name: String, value: Float) throws {
        for goal in goals {            
            if(goal.name == name){
                throw GoalsError.nameAlreadyAdded
            }
        }
        if(value == 0){
            throw ValueError.isZero
        }
        
        goals.append(Goal(name: name, value: value))
        
    }
    
    mutating func editGoalByName(name: String, newName: String) {
        goals = goals.map {
            if($0.name == name){
                return Goal(name: newName, value: $0.value, savedValue: $0.savedValue)
            }
            return $0
        }
    }
    
    mutating func removeGoal(name: String) {
        goals = goals.filter { $0.name != name }
    }
    
    mutating func addValueToAchieveGoal(name: String, value: Float) {
        goals = goals.map {
            if($0.name == name){
                return Goal(name: $0.name, value: $0.value, savedValue: $0.savedValue + value)
            }
            return $0
        }
    }
    
    func checkIsGoalAchieved(name: String) -> Bool {
        for goal in goals {
            if(goal.name == name){
                return goal.valueToAchieveGoal == 0
            }            
        }
        return false
    }
}
