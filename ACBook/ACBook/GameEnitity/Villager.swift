//
//  Villagger.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import Foundation

struct Villager: Decodable {
    var uniqueEntryId: String
    var name: String
    var personality: String
    var species: String
    var birthday: String
    var iconImage: String
    var houseImage: String?
    
    var iconURL: URL {
        URL(string: iconImage)!
    }

    
}
