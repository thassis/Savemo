//
//  UserError.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import Foundation

enum UserError: Error {
    case categoryExceededLimitedValue
    case categoryAlreadyExists
    case operationWithoutValidCategory
}
