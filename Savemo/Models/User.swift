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
    
    private var totalLimitedValueFromCategories: Float  {
        var sum = Float(0);
        categories.forEach { cat in
            sum += cat.limitedValue
        }
        return sum
    }
    
    /*
     //TODO: remove theses constants values and use phone data (CoreData)

    //-------- Constants to be replaced with CoreData --------------
    let creditReais = try! Operation(5000, OperationType.Debit, startDate: Date(), category: DefaultCategories.Education.rawValue)
    let debitReais = try! Operation(480, OperationType.Debit, startDate: Date(), category: DefaultCategories.Education.rawValue)
    let foodCategory = try! Category(name: DefaultCategories.Food.rawValue, limitedValue: 500)
    let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: 500)
    let healthCategory = try! Category(name: DefaultCategories.HealthCare.rawValue, limitedValue: 500)
    let entertainmentCategory = try! Category(name: DefaultCategories.Entertainment.rawValue, limitedValue: 500)
     
     
     
     self.operations = [creditReais, creditReais, debitReais, debitReais, debitReais]
     self.categories = [foodCategory, educationCategory, healthCategory, entertainmentCategory]
   
    //-------- -------- -------- -------- -------- -------- --------
    */
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
    
    func getExceededCategories() -> [Category] {
        var exceededCategories: [Category] = []
        categories.forEach { cat in
            var sum = Float(0)
            operations.forEach { op in
                if(cat.name == op.category){
                    sum += op.value
                }
            }
            if(sum > cat.limitedValue){
                exceededCategories.append(cat)
            }
        }
        return exceededCategories
    }
}
