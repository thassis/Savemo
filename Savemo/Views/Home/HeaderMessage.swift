//
//  SwiftUIView.swift
//  Savemo
//
//  Created by Thiago Assis on 08/11/22.
//

import SwiftUI

struct HeaderMessage: View {
    var valueCanBeSpent: Float
    
    var body: some View {
        if(valueCanBeSpent > 0){
            HStack(alignment: .center, spacing: 4){
                Image(systemName: "checkmark.circle")
                Text("You can spend \(valueCanBeSpent.moneyFormat) this month yet").font(.caption).fontWeight(.bold)
                Spacer()
            }
            .foregroundColor(.green)
        } else {
            HStack(alignment: .center, spacing: 4){
                Image(systemName: "exclamationmark.triangle")
                Text(
                    "You've spent all the money you should this month"
                ).font(.caption).fontWeight(.bold)
                Spacer()
            }
            .foregroundColor(.red)
        }
    }
}

struct HeaderMessage_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("BackgroundColor")
            VStack{
                HeaderMessage(valueCanBeSpent: Float(500))
                HeaderMessage(valueCanBeSpent: Float(0))
                
            }
        }
        
    }
}
