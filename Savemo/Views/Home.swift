//
//  Home.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import SwiftUI

struct Home: View {
    @ObservedObject var homeViewModel: HomeViewModel
    var user: User {
        homeViewModel.user
    }
    
    init(){
        homeViewModel = HomeViewModel()
    }
    
    var body: some View {
        
        VStack{
            HStack {
                Text("Total Balance: ").font(.title)
                Text("R$ " + String(self.user.balance))
            }
            Spacer()
            ScrollView {                
                CategoriesList(categories: self.user.categories)
            }
            Spacer()
            AddOperation(
                onSubmitCredit: { value, description, date in
                    self.homeViewModel.addCredit(value ?? "", description ?? "", date ?? "")
                },
                onSubmitDebit: { value, description, date, category in
                    self.homeViewModel.addDebit(value ?? "", description ?? "", date ?? "", category ?? "")
                }
            )
        }.padding()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
