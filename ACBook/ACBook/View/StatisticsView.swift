//
//  StatisticsView.swift
//  ACBook
//
//  Created by Lorenzo Signoretti on 06/09/22.
//

import SwiftUI

struct StatisticsView: View {
    var viewModel: DataLoader
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var fossils: FetchedResults<FossilsPlayer>
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var arts: FetchedResults<ArtPlayer>
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var creatures: FetchedResults<CreaturePlayer>

    var body: some View {
        List() {
            Section(header: Text("Museum's donations")) {
                ProgressView("Insects", value: Float(creatures.filter{ cre in
                    cre.id < 80
                }.count), total: 80)
                ProgressView("Fishes", value: Float(creatures.filter{ cre in
                    cre.id > 80 && cre.id < 160
                }.count), total: 80)
                ProgressView("Sea creatures", value: Float(creatures.filter{ cre in
                    cre.id >= 160
                }.count), total: 40)
                ProgressView("Fossils", value: Float(fossils.count), total: 73)
                ProgressView("Arts", value: Float(arts.count), total: 43)
            }
            Section(header: Text("This Month")){
                HInfo(key: "Daily's avarage", value: "\(getThisMonthAvg())")
                HInfo(key: "Captured", value: "\(getThisMonthCaptured())")
            }
            
            Section(header: Text("Daily's avarage for month")){
                Chart(measurements: getYearAvg())
            }
            Section(header: Text("Captured for month")){
                Chart(measurements: getYearCaptured())
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Statistics")
    }
    
    private func getYearCaptured() -> [MonthAvr]{
        [
            MonthAvr(month: 0, val: Double(getMonthCaptured(month: 1))),
            MonthAvr(month: 1, val: Double(getMonthCaptured(month: 2))),
            MonthAvr(month: 2, val: Double(getMonthCaptured(month: 3))),
            MonthAvr(month: 3, val: Double(getMonthCaptured(month: 4))),
            MonthAvr(month: 4, val: Double(getMonthCaptured(month: 5))),
            MonthAvr(month: 5, val: Double(getMonthCaptured(month: 6))),
            MonthAvr(month: 6, val: Double(getMonthCaptured(month: 7))),
            MonthAvr(month: 7, val: Double(getMonthCaptured(month: 8))),
            MonthAvr(month: 8, val: Double(getMonthCaptured(month: 9))),
            MonthAvr(month: 9, val: Double(getMonthCaptured(month: 10))),
            MonthAvr(month: 10, val: Double(getMonthCaptured(month: 11))),
            MonthAvr(month: 11, val: Double(getMonthCaptured(month: 12)))
        ]
    }

    private func getYearAvg() -> [MonthAvr]{
        [
            MonthAvr(month: 0, val: getMonthAvg(month: 1)),
            MonthAvr(month: 1, val: getMonthAvg(month: 2)),
            MonthAvr(month: 2, val: getMonthAvg(month: 3)),
            MonthAvr(month: 3, val: getMonthAvg(month: 4)),
            MonthAvr(month: 4, val: getMonthAvg(month: 5)),
            MonthAvr(month: 5, val: getMonthAvg(month: 6)),
            MonthAvr(month: 6, val: getMonthAvg(month: 7)),
            MonthAvr(month: 7, val: getMonthAvg(month: 8)),
            MonthAvr(month: 8, val: getMonthAvg(month: 9)),
            MonthAvr(month: 9, val: getMonthAvg(month: 10)),
            MonthAvr(month: 10, val: getMonthAvg(month: 11)),
            MonthAvr(month: 11, val: getMonthAvg(month: 12))
        ]
    }
    private func getThisMonthCaptured() -> Int{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        let month = components.month!
        return getMonthCaptured(month: month)
        }
    
    private func getMonthCaptured(month: Int) -> Int{
        var count: Int = 0;
        let calendar = Calendar.current
        for cre in creatures{
            if( calendar.dateComponents([.month], from: cre.date!).month == month){
                count = count + 1
            }
        }
        for cre in fossils{
            if( calendar.dateComponents([.month], from: cre.date!).month == month){
                count = count + 1
            }
        }
        for cre in arts{
            if( calendar.dateComponents([.month], from: cre.date!).month == month){
                count = count + 1
            }
        }
        return count
    }
    
    private func getThisMonthAvg() -> Double{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        let month = components.month!
        return getMonthAvg(month: month)
    }
    
    private func getMonthAvg(month: Int) -> Double{
        var totals: [Int] = []
        for day in 1...31{
            totals.append(getDayCaptured(day: day, month: month))
        }
        var avg: Int = 0
        for tot in totals{
            avg += tot
        }
        return Double(avg/31)
    }
    
    private func getDayCaptured(day: Int, month: Int) -> Int{
        let calendar = Calendar.current
        var count: Int = 0
        for cre in creatures{
            if( calendar.dateComponents([.month], from: cre.date!).month == month &&
                calendar.dateComponents([.day], from: cre.date!).day == day){
                count = count + 1
            }
        }
        for cre in fossils{
            if( calendar.dateComponents([.month], from: cre.date!).month == month &&
                calendar.dateComponents([.day], from: cre.date!).day == day){
                count = count + 1
            }
        }
        for cre in arts{
            if( calendar.dateComponents([.month], from: cre.date!).month == month &&
                calendar.dateComponents([.day], from: cre.date!).day == day){
                count = count + 1
            }
        }
        return count
    }
    
}
