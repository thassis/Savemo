//
//  BarChart.swift
//  Savemo
//
//  Created by Thiago Assis on 08/11/22.
//

//the original BarChart can be found in: https://github.com/BLCKBIRDS/Bar-Chart-in-SwiftUI
import SwiftUI

struct BarChart: View {
    
    var barColor: Color
    var data: [ChartData]
    
    @State private var currentValue = ""
    @State private var currentLabel = ""
    
    @State private var touchLocation: CGFloat = -1
    
    var body: some View {
        ZStack{
            Color.white
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        
                        Rectangle().foregroundColor(.black).frame(width: 16.0, height: 16.0).cornerRadius(5)
                        Text("Used Value Lower").font(.caption2).padding(.trailing)
                        
                        Rectangle().foregroundColor(.gray).frame(width: 16.0, height: 16.0).cornerRadius(5)
                        Text("Limited Value").font(.caption2).padding(.trailing)
                        
                    }
                    HStack(spacing: 4) {
                        Rectangle().foregroundColor(.red).frame(width: 16.0, height: 16.0).cornerRadius(5)
                        Text("Used Value Higher").font(.caption2)
                    }
                }
                
                GeometryReader { geometry in
                    VStack {
                        if !currentLabel.isEmpty {
                            Text(currentLabel)
                                .bold()
                                .foregroundColor(.black)
                                .padding(5)
                                .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).shadow(radius: 3))
                                .offset(x: labelOffset(in: geometry.frame(in: .local).width))
                                .animation(.easeIn)
                        }
                        HStack {
                            ForEach(0..<data.count, id: \.self) { i in
                                ZStack{
                                    BarChartCell(
                                        value: data[i].value,
                                        limitedValue: data[i].limitedValue,
                                        normalizedValue: normalizedValue(index: i),
                                        normalizedLimitedValue: normalizedValue(index: i, useLimitedValue: true),
                                        barColor: barColor
                                    )
                                    .opacity(barIsTouched(index: i) ? 1 : 0.7)
                                    .scaleEffect(barIsTouched(index: i) ? CGSize(width: 1.05, height: 1) : CGSize(width: 1, height: 1), anchor: .bottom)
                                    .animation(.spring())
                                    .padding(.top)
                                }
                            }
                        }
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged({ position in
                                let touchPosition = position.location.x/geometry.frame(in: .local).width
                                
                                touchLocation = touchPosition
                                updateCurrentValue()
                            })
                                .onEnded({ position in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation(Animation.easeOut(duration: 2)) {
                                            resetValues()
                                        }
                                    }
                                })
                        )
                    }
                }
                
            }
            .padding()
        }
    }
    
    func normalizedValue(index: Int, useLimitedValue: Bool = false) -> Float {
        var allValues: [Float]    {
            var values = [Float]()
            for data in data {
                values.append(data.value)
                values.append(data.limitedValue)
            }
            return values
        }
        guard let max = allValues.max() else {
            return 1
        }
        if max != 0 {
            return Float(useLimitedValue ? data[index].limitedValue : data[index].value)/Float(max)
        } else {
            return 1
        }
    }
    
    func barIsTouched(index: Int) -> Bool {
        touchLocation > CGFloat(index)/CGFloat(data.count) && touchLocation < CGFloat(index+1)/CGFloat(data.count)
    }
    
    func updateCurrentValue()    {
        let index = Int(touchLocation * CGFloat(data.count))
        guard index < data.count && index >= 0 else {
            currentValue = ""
            currentLabel = ""
            return
        }
        currentValue = "\(data[index].value)"
        currentLabel = data[index].label
    }
    
    func resetValues() {
        touchLocation = -1
        currentValue  =  ""
        currentLabel = ""
    }
    
    func labelOffset(in width: CGFloat) -> CGFloat {
        let currentIndex = Int(touchLocation * CGFloat(data.count))
        guard currentIndex < data.count && currentIndex >= 0 else {
            return 0
        }
        let cellWidth = width / CGFloat(data.count)
        let actualWidth = width -    cellWidth
        let position = cellWidth * CGFloat(currentIndex) - actualWidth/2
        return position
    }
    
}

let chartDataSet: [ChartData] = [
    ChartData(label: "January 2021", value: 340.32, limitedValue: 500),
    ChartData(label: "February 2021", value: 250.0, limitedValue: 340),
    ChartData(label: "March 2021", value: 430.22, limitedValue: 300),
    ChartData(label: "April 2021", value: 350.0, limitedValue: 500),
]

struct BarChart_Previews: PreviewProvider {  
    static var previews: some View {
        BarChart(barColor: .black, data: chartDataSet)
    }
}
