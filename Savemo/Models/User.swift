//
//  User.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import Foundation

struct User {
    private(set) var operations: [Operation]
    private(set) var categories: [Category]
    private(set) var balance: Float
    private(set) var salary: Float
    
    var totalLimitedValueFromCategories: Float  {
        var sum = Float(0);
        categories.forEach { cat in
            sum += cat.limitedValue
        }
        return sum
    }
    
    init(operations: [Operation], categories: [Category], balance: Float, salary: Float) {
        self.operations = operations
        self.categories = categories
        self.balance = balance
        self.salary = salary
    }
    
    mutating func addOperation(_ operation: Operation) throws {
        operations.append(operation)
        if(operation.type == OperationType.Debit){
            if(operation.category == nil){
                throw UserError.operationWithoutValidCategory
            }
            self.balance -= operation.value
        } else {
            self.balance += operation.value
        }
    }
    
    mutating func addCategory(_ category: Category) throws {
        try categories.forEach { cat in
            if cat.name == category.name {
                throw UserError.categoryAlreadyExists
            }
        }
        if(totalLimitedValueFromCategories + category.limitedValue <= salary){
            categories.append(category)
        } else {
            throw UserError.categoryExceededLimitedValue
        }
    }
    
    func getOperationsByMonthYear(month: Int, year: Int) -> [Operation] {
        var operationsByMonthYear: [Operation] = []
        self.operations.forEach { op in
            let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: op.startDate)
            let currentMonth = calendarDate.month!
            let currentYear = calendarDate.year!
            if(currentMonth == month && currentYear == year){
                operationsByMonthYear.append(op)
            }
        }
        return operationsByMonthYear
    }
    
    func getValueCanBeSpentByCategory(_ category: Category, month: Int, year: Int) -> Float {
        let operationsByMonthYear = getOperationsByMonthYear(month: month, year: year)
        var sum = Float(0)
        categories.forEach { cat in
            if(cat.name == category.name){
                operationsByMonthYear.forEach { op in
                    if(op.type == OperationType.Debit
                       && op.category == category.name
                    ){
                        sum += op.value
                    }
                }

            }
        }
        let valueCanBeSpent = category.limitedValue - sum
        if(valueCanBeSpent >= 0){
            return valueCanBeSpent
        }
        return 0
    }
    
    func getValueHaveBeenSpentByCategory(_ category: Category, month: Int, year: Int) -> Float {
        let operationsByMonthYear = getOperationsByMonthYear(month: month, year: year)
        var sum = Float(0)
        categories.forEach { cat in
            if(cat.name == category.name){
                operationsByMonthYear.forEach { op in
                    if(op.type == OperationType.Debit
                       && op.category == category.name
                    ){
                        sum += op.value
                    }
                }

            }
        }
        return sum
    }
    
    func getExceededCategoriesByMonthYear(month: Int, year: Int) -> [Category] {
        var exceededCategories: [Category] = []
        categories.forEach { cat in
            let valueSpent = getValueHaveBeenSpentByCategory(cat, month: month, year: year)
            if(valueSpent > cat.limitedValue){
                exceededCategories.append(cat)
            }
        }
        return exceededCategories
    }
    
    func getValueCanBeSpentAllCategories(month: Int, year: Int) -> Float {
        var sum = Float(0)
        categories.forEach { cat in
            sum += getValueHaveBeenSpentByCategory(cat, month: month, year: year)
        }
        let valueCanBeSpent = salary - sum
        if(valueCanBeSpent >= 0){
            return valueCanBeSpent
        }
        return 0
    }
}
