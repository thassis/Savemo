//
//  Helper.swift
//  Savemo
//
//  Created by Thiago Assis on 08/11/22.
//

import Foundation

extension Float {
    var moneyFormat: String { "R$ \(String(format: "%.2f", self))" }
}
