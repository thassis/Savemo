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
    
    mutating func addOperation(_ operation: Operation){
        operations.append(operation)
        if(operation.type == OperationType.Debit){
            self.balance -= operation.value
        } else {
            self.balance += operation.value
        }
    }
    
    
    
}
