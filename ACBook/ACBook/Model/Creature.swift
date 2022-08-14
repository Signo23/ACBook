//
//  Creature.swift
//  ACBook
//
//  Created by Lorenzo on 08/08/22.
//

import Foundation

struct Creature: Catalogable{
    var id: Int
    var name: String
    var sell: Int
    var source: String
    var weather: String
    var iconImage: String
    var critterpediaImage: String
    var activeMonths: Emispher
    
    var critterpediaImageURL: URL {
        return URL(string: self.critterpediaImage)!
    }
    
    func getType() -> GameEntity {
        return GameEntity(rawValue: source.lowercased())!
    }
    
    func getName() -> String {
        return name
    }
    
    func getID() -> Int {
        return self.id
    }
    
    func getMainImageURL() -> URL {
        return URL(string: self.iconImage)!
    }
    
    func getActiveMothNorthDescription() -> String{
        return "\(Month(rawValue: self.activeMonths.northern[0].month-1)?.info.capitalized ?? "?") - \(Month(rawValue: self.activeMonths.northern.last!.month-1)?.info.capitalized ?? "?")"
    }
    
    func getActiveMothSouthDescription() -> String{
        return "\(Month(rawValue: self.activeMonths.southern[0].month-1)?.info.capitalized ?? "?") - \(Month(rawValue: self.activeMonths.southern.last!.month-1)?.info.capitalized ?? "?")"
    }
    
    func getHoursDescription() -> String{
        return "\(self.activeMonths.northern[0].activeHours[0][0]):00 - \(self.activeMonths.northern[0].activeHours[0][1]):00"
    }
    
    
}

struct Emispher: Decodable {
    var northern: [Active]
    var southern: [Active]
}

struct Active: Decodable {
    var activeHours: [[String]]
    var isAllDay: Bool
    var month: Int
    var season: String
}
