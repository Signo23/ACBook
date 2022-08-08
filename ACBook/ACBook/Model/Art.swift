//
//  Art.swift
//  ACBook
//
//  Created by Lorenzo on 08/08/22.
//
import Foundation

struct Art: Catalogable {
    var id: Int
    var name: String
    var realName: String
    var artist: String
    var price: Int
    var sell: Int
    var imageReal: String
    var imageFake: String
    
    func getType() -> GameEntity {
        return .arts
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getID() -> Int {
        return self.id
    }
    
    func getMainImageURL() -> URL {
        return URL(string: self.imageReal)!
    }
    
    
}
