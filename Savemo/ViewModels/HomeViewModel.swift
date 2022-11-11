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
        //TODO: remove this constant USER values and use phone data (CoreData)
        let TEMP_DATA = HomeViewData_Temp()
        self.user = TEMP_DATA.USER
        print(self.user.operations)
    }
    
    func addOperation(_ value: String, _ description: String, _ date: Date, _ category: String? = nil, type: OperationType) throws {
        do {
            try user.addOperation(Operation(Float((Float(value) ?? 0)/100), type, startDate: date, category: category))
        } catch {
            throw error
        }
    }
    
    func addDebit(_ value: String, _ description: String, _ date: Date, _ category: String) {
        try? addOperation(value, description, date, category, type: OperationType.Debit)
    }
    
    func addCredit(_ value: String, _ description: String, _ date: Date) {
        try? addOperation(value, description, date, type: OperationType.Credit)
    }
    
    func getChartData() -> [ChartData] {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let currentMonth = calendarDate.month!
        let currentYear = calendarDate.year!
        
        var chartData: [ChartData] = []
        self.user.categories.forEach { cat in
            chartData.append(
                ChartData(
                    label: cat.name,
                    value: self.user.getValueHaveBeenSpentByCategory(cat, month: currentMonth, year: currentYear),
                    limitedValue: cat.limitedValue
                )
            )
        }
        return chartData
    }
}
