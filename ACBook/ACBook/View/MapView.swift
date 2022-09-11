//
//  MapView.swift
//  ACBook
//
//  Created by Lorenzo Signoretti on 11/09/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    var locationCoordinates: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion ()
    
    var body: some View {
        Map(coordinateRegion: $region)
            .onAppear {
                setRegion(locationCoordinates)
            }
    }
    
    func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate,
                                    span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
}
