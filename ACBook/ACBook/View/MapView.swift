//
//  MapView.swift
//  ACBook
//
//  Created by Lorenzo Signoretti on 11/09/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region)
            .cornerRadius(5)
    }
}
