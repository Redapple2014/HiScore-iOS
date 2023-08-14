//
//  EnterOTPViewController.swift
//  HiScore
//
//  Created by PC-072 on 10/08/23.
//

import UIKit
import Lottie

class EnterOTPViewController: BaseViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!
    //    private var animationView: LottieAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // 2. Start LottieAnimationView with animation name (without extension)
        
        animationView = .init(name: "REward Gift Box")
        
        animationView!.frame = view.bounds
        
        // 3. Set animation content mode
        
        animationView!.contentMode = .scaleAspectFit
        
        // 4. Set animation loop mode
        
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        
        animationView!.animationSpeed = 1
        
        view.addSubview(animationView!)
        
        // 6. Play animation
        
        animationView!.play()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
