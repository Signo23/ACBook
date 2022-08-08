//
//  File.swift
//  ACBook
//
//  Created by Lorenzo on 06/08/22.
//
import Foundation

protocol Catalogable: Decodable {
    var id: Int {get set}
    
    func getType() -> GameEntity
    func getName() -> String
    func getID() -> Int
    func getMainImageURL() -> URL
}
