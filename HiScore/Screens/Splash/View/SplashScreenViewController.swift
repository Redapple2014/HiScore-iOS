//
//  SPlashScreenViewController.swift
//  HiScore
//
//  Created by PC-072 on 10/08/23.
//

import UIKit
import Kingfisher

class SplashScreenViewController: BaseViewController {
    @IBOutlet weak var splashImageView: UIImageView!
    private var viewModel: SpalshViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = HiScoreNetworkRepository()
        viewModel = SpalshViewModel(networkService: networkService)
        fetchSplashImages()
    }
    func fetchSplashImages() {
        viewModel.getSplashScreenImages { result in
            switch result {
            case .success(let data):
                self.splashImageView.kf.setImage(with: data.data.event.splashScreenUrl)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    if self.isUserCreated {
                        if self.isLocationAllowed {
                            self.navigateToHome()
                        } else {
                            self.navigateToLocation()
                        }
                    } else {
                        self.navigateToOnboarding()
                    }
                }
            case .failure(let error):
                Log.d(error.localizedDescription)
            }
        }
    }
    var isUserCreated: Bool {
        return User.shared.details?.data?.loginToken != nil ? true : false
    }
    var isLocationAllowed: Bool {
        return UserDefaults.standard.bool(forKey: "isLocationAllowed")
    }
    func navigateToOnboarding() {
        guard let viewController = self.storyboard(name: .main)
                .instantiateViewController(withIdentifier: "EnterPhoneNumberViewController") as? EnterPhoneNumberViewController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func navigateToLocation() {
        guard let viewController = self.storyboard(name: .location)
                .instantiateViewController(withIdentifier: "GetLocationViewController") as? GetLocationViewController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func navigateToHome() {
        guard let viewController = self.storyboard(name: .tabBar)
                .instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
