//
//  HomeViewModelTests.swift
//  SavemoTests
//
//  Created by Thiago Assis on 06/11/22.
//

import XCTest

final class HomeViewModelTests: XCTestCase {

    var homeViewModel: HomeViewModel!
    
    override func setUp() {
        let credit = try! Operation(5, OperationType.Credit, startDate: Date())
        
        homeViewModel = HomeViewModel(
            operations: [credit, credit, credit]
        )
    }

    
}
