//
//  File.swift
//  ACBook
//
//  Created by Lorenzo on 09/08/22.
//

import Foundation

enum Month: Int{
    case january, february, march, april, may, june, july, august, september, october, november, december
    
    var info: String{
        switch self {
        case.january:
            return "january"
        case.february:
            return "february"
        case.march:
            return "march"
        case.april:
            return "april"
        case.may:
            return "may"
        case.june:
            return "june"
        case .july:
            return "july"
        case.august:
            return "august"
        case.september:
            return "september"
        case.october:
            return "october"
        case.november:
            return "november"
        case.december:
            return "december"
        }
    }
}
