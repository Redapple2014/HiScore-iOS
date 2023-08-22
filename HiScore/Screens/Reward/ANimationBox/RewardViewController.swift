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
        // 2. Start LottieAnimationView with animation name (without extension)
        
        animationView = .init(name: AnimationFiles.reward)
        
        animationView!.frame = view.bounds
        
        // 3. Set animation content mode
        
        animationView!.contentMode = .scaleAspectFit
        
        // 4. Set animation loop mode
        
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        
        animationView!.animationSpeed = 1
        
        view.addSubview(animationView!)
        
        animationView.stop()
        // 6. Play animation
        animationView!.play ()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.animationView.stop()
            self.moveToHome()
        }
       //
        
    }
    
    func moveToHome() {
//        guard let viewController = self.storyboard(name: .home).instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController else {
//            return
//        }
        guard let viewController = self.storyboard(name: .reward).instantiateViewController(withIdentifier: "RewardPopupViewController") as? RewardPopupViewController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
}
