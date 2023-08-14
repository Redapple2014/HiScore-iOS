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
                print(data.message)
                self.splashImageView.kf.setImage(with: data.data.event.splashScreenUrl)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    let storyboard = UIStoryboard(name: "Location", bundle: nil)
                    guard let viewController = storyboard.instantiateViewController(withIdentifier: "GetLocationViewController") as? GetLocationViewController else {
                        return
                    }
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
