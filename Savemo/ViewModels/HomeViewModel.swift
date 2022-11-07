//
//  HomeViewModel.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published private(set) var user: User
    
    init() {        
        //TODO: remove theses constants values and use phone data (CoreData)
        //-------- Constants to be replaced with CoreData --------------
        let creditReais = try! Operation(5000, OperationType.Debit, startDate: Date(), category: DefaultCategories.Education.rawValue)
        let debitReais = try! Operation(480, OperationType.Debit, startDate: Date(), category: DefaultCategories.Education.rawValue)
        let foodCategory = try! Category(name: DefaultCategories.Food.rawValue, limitedValue: 500)
        let educationCategory = try! Category(name: DefaultCategories.Education.rawValue, limitedValue: 500)
        let healthCategory = try! Category(name: DefaultCategories.HealthCare.rawValue, limitedValue: 500)
        let entertainmentCategory = try! Category(name: DefaultCategories.Entertainment.rawValue, limitedValue: 500)
        //-------- -------- -------- -------- -------- -------- --------
        
        self.user = User(operations: [creditReais, creditReais, debitReais], categories: [foodCategory, educationCategory, healthCategory, entertainmentCategory], balance: 2500, salary: 10000)
    }
    
    func addOperation(_ value: String, _ description: String, _ strDate: String, _ category: String? = nil, type: OperationType) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        let date = dateFormatter.date(from: strDate) ?? Date()
        let test = Float(value) ?? 0
        do {
            try user.addOperation(Operation(Float(value) ?? 0, type, startDate: date, category: category))
        } catch {
            throw error
        }
    }
    
    func addDebit(_ value: String, _ description: String, _ strDate: String, _ category: String) {
        try? addOperation(value, description, strDate, category, type: OperationType.Debit)
    }
    
    func addCredit(_ value: String, _ description: String, _ strDate: String) {
        try? addOperation(value, description, strDate, type: OperationType.Credit)
    }
}
