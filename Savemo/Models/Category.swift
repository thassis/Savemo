//
//  Category.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import Foundation

struct Category {
    private(set) var name: String
    private(set) var limitedValue: Float
    
    init(name: String, limitedValue: Float) throws {
        if(limitedValue == 0){
            throw ValueError.isZero            
        }
        self.name = name
        self.limitedValue = limitedValue
    }
    
}
