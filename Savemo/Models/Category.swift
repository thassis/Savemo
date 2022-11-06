//
//  Category.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import Foundation

struct Category: Equatable {
    private(set) var name: String
    private(set) var limitedValue: Float
    
    init(name: String, limitedValue: Float) throws {
        if(limitedValue == 0){
            throw ValueError.isZero            
        }
        self.name = name
        self.limitedValue = limitedValue
    }
    
    static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name && lhs.limitedValue == rhs.limitedValue
    }
}
