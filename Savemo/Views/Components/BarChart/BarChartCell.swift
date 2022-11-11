//
//  BarChartCell.swift
//  Savemo
//
//  Created by Thiago Assis on 08/11/22.
//

import SwiftUI

struct BarChartCell: View {
    
    var value: Float
    var limitedValue: Float
    var normalizedValue: Float
    var normalizedLimitedValue: Float
    var barColor: Color
    
    init(value: Float, limitedValue: Float, normalizedValue: Float, normalizedLimitedValue: Float, barColor: Color) {
        self.value = value
        self.limitedValue = limitedValue
        self.normalizedValue = normalizedValue
        self.normalizedLimitedValue = normalizedLimitedValue
        if(limitedValue < value){
            self.barColor = .red
        } else {
            self.barColor = barColor
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("GrayLight"))
                    .scaleEffect(CGSize(width: 1, height: Double(normalizedLimitedValue)), anchor: .bottom)
                RoundedRectangle(cornerRadius: 5)
                    .fill(barColor)
                    .scaleEffect(CGSize(width: 1, height: Double(normalizedValue)), anchor: .bottom)
            }
            Text("\(self.limitedValue.moneyFormat)").font(.caption2).foregroundColor(.gray)
            Text("\(self.value.moneyFormat)").font(.caption2).foregroundColor(self.barColor)
            
        }
    }
}

struct BarChartCell_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            BarChartCell(value: 380, limitedValue: 550, normalizedValue: 0.8, normalizedLimitedValue: 1, barColor: .black)
            BarChartCell(value: 200, limitedValue: 400, normalizedValue: 0.7, normalizedLimitedValue: 0.9, barColor: .black)
        }
    }
}
