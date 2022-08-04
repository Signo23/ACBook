//
//  HInfo.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

struct HInfo: View{
    
    var key: String
    var value: String
    
    var body: some View {
        HStack{
            HStack {
                Text(key)
                Spacer()
                Text(value)
                    .foregroundColor(.secondary)
                }
        }
    }
}
