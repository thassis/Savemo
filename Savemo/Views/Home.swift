//
//  Home.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import SwiftUI

struct Home: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @State var isAddPressed = false
    
    var user: User {
        homeViewModel.user
    }
    
    init(){
        homeViewModel = HomeViewModel()
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Color("BackgroundColor")
                .ignoresSafeArea()
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .leading){
                    Text("Savemo")
                        .bold()
                        .font(.largeTitle)
                        .padding(.top)
                    
                    Text("\(self.user.balance.moneyFormat)")
                        .font(.headline)
                    
                    BarChart(barColor: .blue, data: self.homeViewModel.getChartData())
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 2)
                    
                    Text("Adicionar nova categoria")
                    Text("Adicionar nova categoria")
                    Text("Adicionar nova categoria")
                    
                }
                .padding(.vertical)
                
                /*AddOperation(
                 onSubmitCredit: { value, description, date in
                 self.homeViewModel.addCredit(value ?? "", description ?? "", date ?? "")
                 },
                 onSubmitDebit: { value, description, date, category in
                 self.homeViewModel.addDebit(value ?? "", description ?? "", date ?? "", category ?? "")
                 }
                 )
                 .padding()*/
            }
            .padding()
            .overlay(Color.black.opacity(isAddPressed ? 0.5 : 0))
            .ignoresSafeArea()
            .onTapGesture {
                isAddPressed = false
            }
            
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 56.0))
                .foregroundStyle(.white, .blue)
                .onTapGesture {
                    isAddPressed = true
                }
                .padding()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
