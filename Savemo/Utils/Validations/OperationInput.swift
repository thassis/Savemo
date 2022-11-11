//
//  HomeViewModel.swift
//  Savemo
//
//  Created by Thiago Assis on 07/11/22.
//

import Foundation

struct OperationInput {
    
    static func applyRegex(regex: String, str: String) -> Bool {
        let range = NSRange(location: 0, length: str.utf16.count)
        let regex = try! NSRegularExpression(pattern: regex)
        return regex.firstMatch(in: str, options: [], range: range) != nil
    }
    
    static func validateValue(_ value: String) -> Bool {
        return applyRegex(regex: "^[0-9]+$", str: value)
    }
    
    static func validateDate(_ date: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateIsValid = formatter.date(from: date) != nil
        return dateIsValid
    }
    
    static func validateCategory(_ categories: [Category], _ name: String) -> Bool {
        if(name == ""){
            return false
        }
        for category in categories {
            if(category.name == name){
                return false
            }
        }
        return true
    }
    
    static func valueMask(value: String) -> String {
        let lastCharacter = value.last
        var newString: String = ""
        
        for (index, char) in value.enumerated() {
            if(index != value.count - 1){
                newString += String(char)
            } else {
                newString += "0"
            }
        }
        return newString
    }
    
}
