//
//  Chart.swift
//  ACBook
//
//  Created by Lorenzo on 06/09/22.
//

import SwiftUI

struct Chart: View {
    var measurements: [MonthAvr] = [
        MonthAvr(month: 0, yaer: 2022, avg: 20),
        MonthAvr(month: 1, yaer: 2022, avg: 10),
        MonthAvr(month: 2, yaer: 2022, avg: 15),
        MonthAvr(month: 3, yaer: 2022, avg: 6),
        MonthAvr(month: 4, yaer: 2022, avg: 2),
        MonthAvr(month: 5, yaer: 2022, avg: 17),
        MonthAvr(month: 6, yaer: 2022, avg: 6),
        MonthAvr(month: 7, yaer: 2022, avg: 7),
        MonthAvr(month: 8, yaer: 2022, avg: 25),
        MonthAvr(month: 9, yaer: 2022, avg: 20),
        MonthAvr(month: 10, yaer: 2022, avg: 20),
        MonthAvr(month: 11, yaer: 2022, avg: 10)
    ]

    var body: some View {
        ScrollView(.horizontal){
            ZStack{
                ForEach(0..<100) { mark in
                  Rectangle()
                    .fill(Color.gray)
                    .offset(y: CGFloat(mark) * 25.0)
                    .frame(height: 1.0)
                }
                .offset(y:-200)
                HStack {
                      ForEach(0..<12) { month in
                        VStack {
                          Spacer()
                            Text("\(self.measurements[month].avg, specifier: "%.1f" )")
                              .font(.footnote)
                              .rotationEffect(.degrees(-90))
                              .offset(y: self.measurements[month].avg < 2.4 ? 0 : 35)                          .zIndex(1)
                          Rectangle()
                                .fill(.blue)
                            .frame(width: 20, height: CGFloat(self.measurements[month].avg) * 15.0)
                            Text("\(self.monthAbbreviationFromInt(month))")
                            .font(.footnote)
                            .frame(height: 20)
                        }
                      }
                    }
            }

        }
    }
    
    func monthAbbreviationFromInt(_ month: Int) -> String {
      let ma = Calendar.current.shortMonthSymbols
      return ma[month]
    }
}

struct MonthAvr{
    var month: Int
    var yaer: Int
    var avg: Double
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        Chart()
    }
}
