//
//  GetLocationViewController.swift
//  HiScore
//
//  Created by RATPC-043 on 14/08/23.
//

import Foundation
import UIKit
import MHLoadingButton
import CoreLocation

class GetLocationViewController: BaseViewController {
    @IBOutlet weak var buttonShareLocation: LoadingButton!
    let locationManager = CLLocationManager()
    private var lat = ""
    private var long = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonShareLocation.setUpButtonWithGradientBackground(type: .yellow)
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchLocation()
    }
}
// MARK: - Navigation
extension GetLocationViewController: CLLocationManagerDelegate {
    @objc func fetchLocation() {
        DispatchQueue.global().async {
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        Log.d("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude.description
        long = locValue.longitude.description
        locationManager.stopUpdatingLocation()
    }
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            Log.d("not determined - hence ask for Permission")
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            Log.d("permission denied")
        case .authorizedAlways, .authorizedWhenInUse:
            Log.d("Apple delegate gives the call back here once user taps Allow option, Make sure delegate is set to self")
        @unknown default:
            fatalError()
        }
    }
}
extension GetLocationViewController {
    @IBAction func shareLocationDidTap(_ sender: Any){
        shareLocation(lat: lat, long: long)
    }
    func shareLocation(lat: String, long: String) {
        self.showFetchLocationPopUp()
    }
}
