//
//  LocationViewModel.swift
//  ACBook
//
//  Created by Lorenzo on 04/09/22.
//

import Foundation
import CoreLocation

class LocationViewModel: NSObject, ObservableObject {
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    
    private let locationManager = CLLocationManager()
    
    override init(){
        super.init()
        self.locationManager.delegate = self
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        if (Calendar.current.isDateInToday(location.timestamp)) {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            print("Location: \(location)")
            manager.stopMonitoringSignificantLocationChanges()
        }
    }
    
    func startMySignificantLocationChanges() {
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            // The device does not support this service.
            return
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       if let error = error as? CLError, error.code == .denied {
          // Location updates are not authorized.
          manager.stopMonitoringSignificantLocationChanges()
          return
       }
       // Notify the user of any errors.
        print("\(error)")
    }

}
