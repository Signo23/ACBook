//
//  Villagger.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import Foundation

struct Villager: Catalogable {
    
    var id: Int
    var name: String
    var gender: String
    var personality: String
    var species: String
    var birthday: String
    var iconImage: String
    var houseImage: String
    var style: String
    var houseURL: URL {
        return URL(string: houseImage)!
    }

    
    
    func getType() -> GameEntity {
        .villagers
    }
    
    func getName() -> String {
        return name.capitalized
    }
    
    func getID() -> Int {
        return id
    }
    
    func getMainImageURL() -> URL {
        return URL(string: iconImage)!
    }
    
}
