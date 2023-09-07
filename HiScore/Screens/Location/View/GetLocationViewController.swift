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
    private var isLocationFetched = false
    private var viewModel: LocationViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = HiScoreNetworkRepository()
        viewModel = LocationViewModel(networkService: networkService)
    }
    override func viewWillAppear(_ animated: Bool) { }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonShareLocation.setNeedsLayout()
        buttonShareLocation.layoutIfNeeded()
        buttonShareLocation.setCornerBorder(color: .HSYellowButtonColor,
                                         cornerRadius: 10,
                                         borderWidth: 0.8)
        buttonShareLocation.setUpButtonWithGradientBackground(type: .yellow)
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
            } else {
                self.showAcessDeniedAlert()
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        Log.d("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude.description
        long = locValue.longitude.description
        if !isLocationFetched {
            shareLocation(lat: lat, long: long)
            isLocationFetched = true
        }
        locationManager.stopUpdatingLocation()
    }
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // "not determined - hence ask for Permission"
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // "permission denied"
            showAcessDeniedAlert()
        case .authorizedAlways, .authorizedWhenInUse: break
            // "Apple delegate gives the call back here once user taps Allow option, Make sure delegate is set to self"
        @unknown default:
            fatalError()
        }
    }
    func showAcessDeniedAlert() {
        let attributedText = NSMutableAttributedString(string: Messages.locationmessage.description,
                                                       attributes: [NSAttributedString.Key.font: UIFont.MavenPro.Bold.withSize(14)])
        let alertController = UIAlertController(title: Messages.locationTitle.description,
                                                    message: "",
                                                    preferredStyle: .alert)
        alertController.setValue(attributedText, forKey: "attributedMessage")
        let cancelAction = UIAlertAction(title: Messages.cancel.description, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let settingsAction = UIAlertAction(title: Messages.settings.description, style: .default) { alertAction in

            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings as URL)
            }
        }
        alertController.addAction(settingsAction)
        present(alertController, animated: true, completion: nil)
    }
}
extension GetLocationViewController {
    @IBAction func shareLocationDidTap(_ sender: Any) {
        fetchLocation()
        isLocationFetched = false
        switch locationManager.authorizationStatus {
        case .notDetermined, .restricted:
            self.locationManager.requestWhenInUseAuthorization()
        case .denied:
            self.showAcessDeniedAlert()
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    func shareLocation(lat: String, long: String) {
        self.showFetchLocationPopUp()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.viewModel.getLocationData(lat: lat,
                                           long: long) { result in
                DispatchQueue.main.async {
                    self.hideFetchLocationPopUp()
                    switch result {
                    case .success(let response):
                        Log.d(response)
                        if response.data.rummy.isAllowed {
                            UserDefaults.standard.set(true, forKey: "isLocationAllowed")
                            guard let userData = User.shared.details?.data,
                                  let isNewUser = userData.isNewUser,
                                  let isDuplicateUser = userData.dupe else { return }
                            if isNewUser {
                                if isDuplicateUser {
                                    // Navigate to offer
                                    guard let viewController = self.storyboard(name: .offer)
                                            .instantiateViewController(withIdentifier: "OfferViewController") as? OfferViewController else {
                                        return
                                    }
                                    self.navigationController?.pushViewController(viewController, animated: true)
                                    return
                                } else {
                                    // Navigate to reward
                                    guard let viewController = self.storyboard(name: .reward)
                                            .instantiateViewController(withIdentifier: "RewardViewController") as? RewardViewController else {
                                        return
                                    }
                                    self.navigationController?.pushViewController(viewController, animated: true)
                                    return
                                }
                            } else {
                                guard let viewController = self.storyboard(name: .tabBar)
                                        .instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController else {
                                    return
                                }
                                self.navigationController?.pushViewController(viewController, animated: true)
                                return

                            }
                        }
                        guard let viewController = self.storyboard(name: .location)
                                .instantiateViewController(withIdentifier: "DisableLocationViewController") as? DisableLocationViewController else {
                            return
                        }
                        viewController.viewModel.errorText = response.data.rummy.error
                        self.navigationController?.pushViewController(viewController, animated: true)
                    case .failure(let error):
                        Log.d(error)
                    }
                }
            }
        }
    }
}
