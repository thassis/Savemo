//
//  HomeViewModel.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published private(set) var operations: [Operation]
    
    init(operations: [Operation]) {
        self.operations = operations
    }
}
