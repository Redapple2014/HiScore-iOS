//
//  RewardPopupViewController.swift
//  HiScore
//
//  Created by PC-072 on 21/08/23.
//

import UIKit
import MHLoadingButton

class RewardPopupViewController: BaseViewController {
    @IBOutlet weak var labelGreetingText: UILabel!
    @IBOutlet weak var labelMObileNUmber: UILabel!

    @IBOutlet weak var viwRewardPopup: RewardPopupView!
    @IBOutlet weak var tableMyReward: UITableView!
    
    @IBOutlet weak var labelRewardSubTitle: UILabel!
    @IBOutlet weak var labelRewardAmount: UILabel!
    
    @IBOutlet weak var labelHurryUP: UILabel!
    
    @IBOutlet weak var viewBetween: ChainView!
    
    @IBOutlet weak var viewTimerSection: UIView!
    @IBOutlet weak var heightOfTimer: NSLayoutConstraint!
    @IBOutlet weak var viewKnowMore: UIView!
    @IBOutlet weak var viewTop: UIView!
//    @IBOutlet weak var : UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var circle1: UIView!
    @IBOutlet weak var circle2: UIView!
    @IBOutlet weak var buttonContinue: LoadingButton!
    var viewModel: RewardPopupViewModel!
    var rewardResponse: RewardPopupResponseModel?
    @IBOutlet weak var labelTimerText: GradientLabel!
    var counter = 0
    var timer: Timer?

}
extension RewardPopupViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = HiScoreNetworkRepository()
        viewModel = RewardPopupViewModel(networkService: networkService)
        getRewardData()
        initUI()
        drawStroke()
        createCircleUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        invalidTimer()
    }

}

extension RewardPopupViewController {
    @IBAction func buttonContinue(_ sender: Any) {
        
    }
    @objc func updateCounter() {
        if counter > -1 {
                self.labelTimerText.text = getTimeRemainingText(time: counter)
            counter -= 1
        } else {
            timer?.invalidate()
        }
    }
}
extension RewardPopupViewController {
    func showTimerWithAnimation() {
        // Unhide the view before animating
            viewTimerSection.isHidden = false
            // Initial position for animation (below the screen)
        viewTimerSection.transform = CGAffineTransform(translationX: 0, y: viewTimerSection.frame.size.height)
            UIView.animate(withDuration: 0.5, animations: {
                // Animate the view to its original position (no translation)
                self.viewTimerSection.transform = .identity
            })
    }
    func invalidTimer() {
        counter = 0
        if timer != nil {
            timer?.invalidate()
        }
    }

    private func getRewardData() {
        viewModel.getRewardData { response in
            switch response {
            case .success(let response):
                self.rewardResponse = response
                self.showText()
                break
            case .failure(let error):
                self.showSnackbarError(title: "", subtitle: error.localizedDescription)
                Log.d(error)
                
                break
            }
        }
    }
}


extension RewardPopupViewController {
    func getTimeRemainingText(time: Int) -> String {
        let sec = time/1000
        let hours = sec / 3600
        let minutes = (sec % 3600) / 60
        let seconds = sec % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private func showText() {
        guard let data = self.rewardResponse?.data else { return }
        labelGreetingText.text = data.greetingSection.subtitle
        labelMObileNUmber.text = "Hi \(data.greetingSection.username)"
        labelRewardSubTitle.text = data.rewardSection.totalRewardSubtitle
        labelRewardAmount.text = "₹\(data.rewardSection.totalRewardReceived)"
        labelHurryUP.text = data.hurryUpSection.hurrySubtitle
        tableMyReward.reloadData()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        counter = self.rewardResponse?.data.hurryUpSection.timeLeft ?? 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showTimerWithAnimation()
        }
    }
    private func initUI() {
        viewTimerSection.isHidden = true
        viewTimerSection.setGradientBackground(colorTop: UIColor.init(hex: "452735"), colorBottom: UIColor.init(hex: "221E2F"))
        labelTimerText.gradientColors = [UIColor(hex: "FFC2C2").cgColor, UIColor(hex: "FF8585").cgColor]
//        viewTop.setGradientBackground(colorTop: UIColor.init(hex: "272B40"),colorBottom: UIColor.init(hex: "181C31"))
        viewBottom.setGradientBackground(colorTop: UIColor(hex: "393D51"), colorBottom: UIColor.init(hex: "14182A"))
        buttonContinue.setUpButtonWithGradientBackground(type: .yellow)
        designKnowMoreView()
        tableMyReward.dataSource = self
    }
    private func designKnowMoreView() {
        viewKnowMore.layer.cornerRadius = 11
        let shadows = UIView()
        shadows.frame = viewKnowMore.frame
        shadows.clipsToBounds = false
        viewKnowMore.addSubview(shadows)
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 11)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 4
        layer0.shadowOffset = CGSize(width: 0, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        let shapes = UIView()
        shapes.frame = viewKnowMore.frame
        shapes.clipsToBounds = true
        viewKnowMore.addSubview(shapes)
        let layer1 = CALayer()
        layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
        shapes.layer.cornerRadius = 11
        
    }
    private func createCircleUI() {
        circle1.circleUI()
        circle2.circleUI()
    }
    private func drawStroke() {
    }
}
extension RewardPopupViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rewardResponse?.data.rewardSection.allRewards.horizontalSet.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MyRewardsTableViewCell else {
            return MyRewardsTableViewCell()
        }
        guard let res = self.rewardResponse,
              let data = res.data as? RewardDataClass,
              let reward = data.rewardSection as? RewardSection,
              let allReward = reward.allRewards as? AllRewards,
              let list = allReward.horizontalSet as? [HorizontalSet] else { return MyRewardsTableViewCell()}
        cell.configCell(data: list[indexPath.row] )
        return cell
    }
    
    
}
