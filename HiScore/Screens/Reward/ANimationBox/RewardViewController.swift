//
//  RewardViewController.swift
//  HiScore
//
//  Created by PC-072 on 18/08/23.
//

import UIKit
import Lottie

class RewardViewController: BaseViewController {
    @IBOutlet weak var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateView()
    }
    private func animateView() {
        //Start LottieAnimationView with animation name (without extension)
        animationView = .init(name: AnimationFiles.reward)
        animationView!.frame = view.bounds
        //Set animation content mode
        animationView!.contentMode = .scaleAspectFit
        //Set animation loop mode
        animationView!.loopMode = .loop
        //Adjust animation speed
        animationView!.animationSpeed = 1
        view.addSubview(animationView!)
        animationView.stop()
        //Play animation
        animationView!.play ()
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
