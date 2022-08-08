//
//  HInfoFieldCode.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI

struct HInfoFieldCode: View {
    @State var code: String = ""
    var key: String = ""
    
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            TextField("0000 0000 0000", value: $code, formatter: NumberFormatter()/*iOS 15 -> .number*/)
                .foregroundColor(.secondary)
            }

    }
}

struct HInfoFieldCode_Previews: PreviewProvider {
    static var previews: some View {
        HInfoFieldCode()
    }
}
