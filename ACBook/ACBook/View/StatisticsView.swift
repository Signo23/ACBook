//
//  StatisticsView.swift
//  ACBook
//
//  Created by Giusy Messina on 06/09/22.
//

import SwiftUI

struct StatisticsView: View {
    var viewModel: DataLoader
    var body: some View {
        List() {
            Section(header: Text("Museum's donations")) {
                ProgressView("Insects", value: 64, total: 80)
                    ProgressView("Fishes", value: 54, total: 80)
                    ProgressView("Sea creatures", value: 29, total: 40)
                    ProgressView("Fossils", value: 73, total: 73)
                    ProgressView("Arts", value: 12, total: 43)
            }
            Section(header: Text("This Month")){
                HInfo(key: "Daily's avarage", value: "5")
                HInfo(key: "Captured", value: "12")
            }
            
            Section(header: Text("Daily's avarage for month")){
                Chart(measurements: avg)
            }
            Section(header: Text("Captured for month")){
                Chart(measurements: month)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Statistics")
    }
    
    var month: [MonthAvr] = [
        MonthAvr(month: 0, val: 20),
        MonthAvr(month: 1, val: 10),
        MonthAvr(month: 2, val: 15),
        MonthAvr(month: 3, val: 6),
        MonthAvr(month: 4, val: 2),
        MonthAvr(month: 5, val: 17),
        MonthAvr(month: 6, val: 6),
        MonthAvr(month: 7, val: 7),
        MonthAvr(month: 8, val: 25),
        MonthAvr(month: 9, val: 20),
        MonthAvr(month: 10, val: 20),
        MonthAvr(month: 11, val: 10)
    ]
    
    var avg: [MonthAvr] = [
        MonthAvr(month: 0, val: 2),
        MonthAvr(month: 1, val: 3),
        MonthAvr(month: 2, val: 5),
        MonthAvr(month: 3, val: 6),
        MonthAvr(month: 4, val: 2),
        MonthAvr(month: 5, val: 7),
        MonthAvr(month: 6, val: 6),
        MonthAvr(month: 7, val: 7),
        MonthAvr(month: 8, val: 5),
        MonthAvr(month: 9, val: 2),
        MonthAvr(month: 10, val: 2),
        MonthAvr(month: 11, val: 1)
    ]
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(viewModel: DataLoader())
    }
}
