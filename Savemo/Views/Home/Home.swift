//
//  Home.swift
//  Savemo
//
//  Created by Thiago Assis on 06/11/22.
//

import SwiftUI

let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
let currentMonth = calendarDate.month!
let currentYear = calendarDate.year!

struct Home: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @State var isAddPressed = false
    @State private var showSheet = false
    
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
                VStack(alignment: .leading, spacing: 8){
                    Text("Savemo")
                        .bold()
                        .font(.largeTitle)
                        .padding(.top)
                    
                    Text("\(self.user.balance.moneyFormat)")
                        .font(.headline)
                    
                    HeaderMessage(
                        valueCanBeSpent: self.user.getValueCanBeSpentAllCategories(
                            month: currentMonth, year: currentYear
                        )
                    )
                    
                    BarChart(barColor: .blue, data: self.homeViewModel.getChartData())
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                   
                    Button(action: {isAddPressed = true}) {
                        HStack{
                            Text("See your goals")
                            Image(systemName: "arrow.right")
                        }
                    }.padding(.vertical)
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
            .overlay(Color.black.opacity(isAddPressed ? 0.7 : 0))
            .ignoresSafeArea()
            .onTapGesture {
                isAddPressed = false
            }
            
            VStack(alignment: .trailing, spacing: 0){
                if(isAddPressed){
                    HStack(alignment: .center){
                        Text("Register Debit").foregroundColor(.white).fontWeight(.bold)
                        Image(
                            systemName: "minus.circle.fill"
                        )
                        .font(.system(size: 30.0))
                        .foregroundColor(.white)
                    }
                    .onTapGesture {
                        showSheet.toggle()
                    }
                    .sheet(isPresented: $showSheet) {
                        SheetView()
                    }
                    .padding()
                    HStack(alignment: .center){
                        Text("Register Credit").foregroundColor(.white).fontWeight(.bold)
                        Image(
                            systemName: "plus.circle.fill"
                        )
                        .font(.system(size: 30.0))
                        .foregroundColor(.white)
                    }.padding([.bottom, .horizontal])
                }
                
                Image(systemName: isAddPressed ? "xmark.circle.fill" : "plusminus.circle.fill")
                    .font(.system(size: 56.0))
                    .foregroundStyle(.white, .blue)
                    .onTapGesture {
                        isAddPressed.toggle()
                    }
            }
            .padding()
        }
    }
}

struct SheetView: View {
   @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
           Button {
              dismiss()
           } label: {
               Image(systemName: "xmark.circle")
                 .font(.largeTitle)
                 .foregroundColor(.gray)
           }
         }
         .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
         .padding()
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
