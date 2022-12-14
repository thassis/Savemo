//
//  Credit.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import Foundation

struct Operation: Equatable {
    private(set) var value: Float
    private(set) var type: OperationType
    private(set) var startDate: Date
    private(set) var category: String?
    private(set) var description: String?
    
    init(_ value: Float, _ type: OperationType, startDate: Date, category: String? = nil, description: String? = nil) throws {
        
        if(value == 0){
            throw ValueError.isZero
        }
        
        self.value = value
        self.type = type
        self.category = category
        self.startDate = startDate
        self.description = description
    }
    
    static func ==(lhs: Operation, rhs: Operation) -> Bool {
        return lhs.value == rhs.value && lhs.type == rhs.type && lhs.startDate == rhs.startDate && lhs.category == rhs.category && lhs.description == rhs.description
    }
    
}
