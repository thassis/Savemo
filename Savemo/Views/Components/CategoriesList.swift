//
//  CategoriesList.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import SwiftUI

struct CategoriesList: View {
    var categories: [Category]
    
    var body: some View {
        VStack{
            Text("Categories List").font(.headline)
            ForEach(categories) { category in
                VStack(alignment: .leading){
                    Text(category.name).padding(.top)
                    Text("Valor limite: R$ \(String(format: "%.2f", category.limitedValue))")
                    /*Text("Gastou: R$ 500,00").foregroundColor(.red)
                    Text("Pode gastar: R$ 500,00").foregroundColor(.green)*/
                }.padding()
            }
        }
    }
}

struct CategoriesList_Previews: PreviewProvider {
    static var previews: some View {
        let cat = try! Category(name: DefaultCategories.Food.rawValue, limitedValue: 500)
        CategoriesList(categories: [cat, cat, cat])
    }
}
