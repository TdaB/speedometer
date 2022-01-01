import Foundation
import CoreLocation
import Combine
import MapKit
import SwiftUI

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    let objectWillChange = PassthroughSubject<Void, Never>()
    let green: Color = Color(red: 0, green: 1, blue: 0, opacity: 1)
    let red: Color = Color(red: 1, green: 0, blue: 0, opacity: 1)
 
    @Published var speed: String = "?" {
        willSet { objectWillChange.send() }
    }
    
    @Published var speedColor: Color = .purple {
        willSet { objectWillChange.send() }
    }
    
    @Published var speedAccuracy: String = "?" {
        willSet { objectWillChange.send() }
    }

    override init() {
        super.init()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if (location.speedAccuracy >= 0) {
            let s: Double = 2.23694 * location.speed
            self.speed = String(format: "%.0f", s)
            self.speedColor = interpolate(color1: green,
                                          color2: red,
                                          fraction: s / 100)
            self.speedAccuracy = String(format: "%.1f", 2.23694 * location.speedAccuracy)
        }
    }
}
