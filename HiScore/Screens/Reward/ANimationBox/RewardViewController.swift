//
//  RewardViewController.swift
//  HiScore
//
//  Created by PC-072 on 18/08/23.
//

import UIKit
import Lottie
class RewardViewController: BaseViewController {
    
    var animationView = LottieAnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateView()
    }
    
    private func animateView() {
        animationView = .init(name: AnimationFiles.reward)
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop//.repeat(2)
        animationView.animationSpeed = 1
        view.addSubview(animationView)
        animationView.stop()
        animationView.play ()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.animationView.stop()
            self.moveToHome()
        }
    }
    
    func moveToHome() {
        guard let viewController = self.storyboard(name: .reward).instantiateViewController(withIdentifier: "RewardPopupViewController") as? RewardPopupViewController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
