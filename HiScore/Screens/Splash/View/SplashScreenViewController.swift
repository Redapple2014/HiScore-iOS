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
                    if User.shared.details?.data?.loginToken != nil {
                        if UserDefaults.standard.bool(forKey: "isLocationAllowed") {
                            guard let viewController = self.storyboard(name: .home).instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController else {
                                return
                            }
                            self.navigationController?.pushViewController(viewController, animated: true)
                        } else {
                            guard let viewController = self.storyboard(name: .location).instantiateViewController(withIdentifier: "GetLocationViewController") as? GetLocationViewController else {
                                return
                            }
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                    } else {
                        guard let viewController = self.storyboard(name: .main).instantiateViewController(withIdentifier: "EnterPhoneNumberViewController") as? EnterPhoneNumberViewController else {
                            return
                        }
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            case .failure(let error):
                Log.d(error.localizedDescription)
            }
        }
    }
}
