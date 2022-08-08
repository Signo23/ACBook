//
//  Fossils.swift
//  ACBook
//
//  Created by Lorenzo on 08/08/22.
//

import Foundation

struct Fossils: Catalogable {
    var id: Int
    var name: String
    var fossilGroup: String
    var source: String
    var sell: Int
    var image: String
    
    func getType() -> GameEntity {
        return .fossils
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getID() -> Int {
        return self.id
    }
    
    func getMainImageURL() -> URL {
        return URL(string: self.image)!
    }
    
    
}
