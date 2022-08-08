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
    var wheather: String?
    var iconImage: String
    var critterpediaImage: String
    var activeMonths: Emispher
    
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
