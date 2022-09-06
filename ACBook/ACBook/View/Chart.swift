//
//  Chart.swift
//  ACBook
//
//  Created by Lorenzo on 06/09/22.
//

import SwiftUI

struct Chart: View {
    var measurements: [MonthAvr]

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
                            Text("\(self.measurements[month].val, specifier: "%.1f" )")
                              .font(.footnote)
                              .rotationEffect(.degrees(-90))
                              .offset(y: self.measurements[month].val < 2.4 ? 0 : 35)
                              .zIndex(1)
                          Rectangle()
                                .fill(.blue)
                            .frame(width: 20, height: CGFloat(self.measurements[month].val) * 15.0)
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
    var val: Double
}

