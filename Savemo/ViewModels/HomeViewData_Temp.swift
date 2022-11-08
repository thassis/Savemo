//
//  HomeViewData.swift
//  Savemo
//
//  Created by Thiago Assis on 08/11/22.
//

import Foundation

//TODO: remove theses constants values and use phone data (CoreData)
//-------- Constants to be replaced with CoreData --------------

let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: 1000)
let foodCategory = try! Category(name: DefaultCategories.Food.rawValue, limitedValue: 2000)
let healthCategory = try! Category(name: DefaultCategories.HealthCare.rawValue, limitedValue: 400)
let entertainmentCategory = try! Category(name: DefaultCategories.Entertainment.rawValue, limitedValue: 1700)

struct HomeViewData_Temp {
    var USER = User(categories: [foodCategory, educationCategory, entertainmentCategory, healthCategory], balance: 2500, salary: 5000)
    
    init(){
        try! USER.addOperation(Operation(1700, OperationType.Debit, startDate: Date(), category: DefaultCategories.Food.rawValue))
        try! USER.addOperation(Operation(100, OperationType.Debit, startDate: Date(), category: DefaultCategories.Education.rawValue))
        try! USER.addOperation(Operation(1300, OperationType.Debit, startDate: Date(), category: DefaultCategories.HealthCare.rawValue))
        try! USER.addOperation(Operation(1500, OperationType.Debit, startDate: Date(), category: DefaultCategories.Entertainment.rawValue))
    }
    
}

//-------- -------- -------- -------- -------- -------- --------
