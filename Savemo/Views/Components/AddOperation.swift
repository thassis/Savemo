//
//  AddOperation.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import SwiftUI

struct AddOperation: View {
    
    @State private var creditValue: String = ""
    @State private var creditDescription: String = ""
    @State private var creditDate: String = ""
    
    @State private var debitValue: String = ""
    @State private var debitDescription: String = ""
    @State private var debitDate: String = ""
    @State private var debitCategory: String = ""
    
    
    var onSubmitCredit: (String?, String?, String?) -> Void
    var onSubmitDebit: (String?, String?, String?, String?) -> Void
    
    init(
        onSubmitCredit: @escaping (String?, String?, String?) -> Void,
        onSubmitDebit: @escaping (String?, String?, String?, String?) -> Void)
    {
        self.onSubmitCredit = onSubmitCredit
        self.onSubmitDebit = onSubmitDebit
    }
    
    var body: some View {
        Image(systemName: "plus.circle.fill")
            .font(.system(size: 56.0))
            .foregroundColor(.blue)
       
        /*VStack(alignment: .leading) {
            HStack {
                TextField(
                    "Value",
                    text: $creditValue
                )
                TextField(
                    "Description",
                    text: $creditDescription
                )
                TextField(
                    "Date",
                    text: $creditDate
                )
            }
            
            Button("Add Credit") {
                self.onSubmitCredit(creditValue, creditDescription, creditDate)
            }.padding(.bottom)
            
            HStack {
                TextField(
                    "Value",
                    text: $debitValue
                )
                TextField(
                    "Description",
                    text: $debitDescription
                )
            }
            HStack {
                TextField(
                    "Date",
                    text: $debitDate
                )
                TextField(
                    "Category",
                    text: $debitCategory
                )
            }
            Button("Add Debit") {
                self.onSubmitDebit(
                    debitValue, debitDescription, debitDate, debitCategory
                )
            }
        }.padding()
        
        */
    }
}

struct AddOperation_Previews: PreviewProvider {
    static var previews: some View {
        AddOperation(
            onSubmitCredit: { value, description, date in
                print(value ?? "")
            },
            onSubmitDebit: { value, description, date, category in
                print(value ?? "")
            }
        )
    }
}
