//
//  HInfoFieldCode.swift
//  ACBook
//
//  Created by Lorenzo on 05/08/22.
//

import SwiftUI


struct HInfoFieldCode: View {
    var key: String = ""
    @State var code: String = ""
    
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            TextField("0000 0000 0000", text: $code)
                .foregroundColor(.secondary)
                .submitLabel(SubmitLabel.done)
            }
    }
}

struct HInfoFieldCode_Previews: PreviewProvider {
    static var previews: some View {
        HInfoFieldCode()
    }
}
