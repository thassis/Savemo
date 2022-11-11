//
//  AddOperation.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

struct AddOperationSheetModal: View {
    @Environment(\.dismiss) var dismiss
    private let numberFormatter: NumberFormatter
    
    @State private var value = 0
    @State private var description: String = ""
    @State private var date = Date()
    @State private var selectedCategory = "Food"
    
    var onSubmitCredit: ((String?, String?, Date?) -> Void)?
    var onSubmitDebit: ((String?, String?, Date?, String?) -> Void)?
    var categoriesName: [String]
    var isDebitOpertaion: Bool
    
    init(
        categoriesName: [String],
        isDebitOpertaion: Bool,
        onSubmitCredit: ((String?, String?, Date?) -> Void)? = nil,
        onSubmitDebit: ((String?, String?, Date?, String?) -> Void)? = nil
    )
    {
        self.categoriesName = categoriesName
        self.isDebitOpertaion = isDebitOpertaion
        self.onSubmitCredit = onSubmitCredit
        self.onSubmitDebit = onSubmitDebit
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
    }
    
    var body: some View {
        VStack {
            VStack{
                ZStack(alignment: .topTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .padding()
                
                HStack{
                    Text("Register \(self.isDebitOpertaion ? "Debit" : "Credit")").font(.largeTitle)
                    Spacer()
                }
                
            }
            
            VStack(alignment: .leading) {
                CurrencyTextField(numberFormatter: numberFormatter, value: $value)
                    .frame(height: 100)
                
                TextField(
                    "Description",
                    text: $description
                ).font(.title3)
                
                Divider()
                
                if(self.isDebitOpertaion) {
                    HStack(alignment: .center) {
                        Text("Pick a category")
                        Spacer()
                        Picker("Category", selection: $selectedCategory) {
                            ForEach(categoriesName, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .background {
                            RoundedRectangle(cornerRadius: 5).foregroundColor(Color("BackgroundColor"))
                        }.accentColor(.black)
                    }
                    .padding(.top)
                }
                
                DatePicker("Pick a date", selection: $date, displayedComponents: [.date])
                   .padding(.top)
                
                Button {
                    dismiss()
                    if(self.isDebitOpertaion) {
                        if let temp = self.onSubmitDebit {
                            return temp(String(value), description, date, selectedCategory)
                        }
                    } else {
                        if let temp = self.onSubmitCredit {
                            return temp(String(value), description, date)
                        }
                    }
                } label: {
                    Text("Create")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                .accentColor(.black)
                .padding(.top, 36)
            }
            
            Spacer()
        }
    }
}

struct AddOperationSheetModal_Previews: PreviewProvider {
    static var previews: some View {
        AddOperationSheetModal(
            categoriesName: [
                DefaultCategories.Food.rawValue,
                DefaultCategories.Education.rawValue,
                DefaultCategories.Entertainment.rawValue,
                DefaultCategories.HealthCare.rawValue
            ],
            isDebitOpertaion: true,
            /* onSubmitCredit: { value, description, date in
             print(value ?? "")
             },*/
            onSubmitDebit: { value, description, date, category in
                print(value ?? "")
            }
        )
    }
}
