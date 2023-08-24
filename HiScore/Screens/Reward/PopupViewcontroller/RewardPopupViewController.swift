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
    
    @IBOutlet weak var viewBetween: UIView!
    
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
extension RewardPopupViewController: RewardPopupDelegate {
    func okayTapped() {
        self.viwRewardPopup.isHidden = true
    }
}
extension RewardPopupViewController {
    @IBAction func buttonKnowMore(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.viwRewardPopup.buttonCross.transform = CGAffineTransform(translationX: 0, y: self.viwRewardPopup.buttonCross.frame.size.height)
                UIView.animate(withDuration: 0.2, animations: {
                    self.viwRewardPopup.isHidden = true
                    self.viwRewardPopup.buttonCross.transform = .identity
                })
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viwRewardPopup.viewCintainer.transform = CGAffineTransform(translationX: 0, y: self.viwRewardPopup.viewCintainer.frame.size.height)
                UIView.animate(withDuration: 0.4, animations: {
                    self.viwRewardPopup.isHidden = false
                    self.viwRewardPopup.viewCintainer.transform = .identity
                })
        }

        self.viwRewardPopup.delegate = self
        guard let data = self.rewardResponse?.data.knowMoreSection.rewardsList else { return }
        self.viwRewardPopup.showDefaultData(data: data[0], type: .depositCash)
        self.viwRewardPopup.showDefaultData(data: data[1], type: .winningCash)
        self.viwRewardPopup.showDefaultData(data: data[2], type: .rummyCash)
        self.viwRewardPopup.showDefaultData(data: data[3], type: .freeEntryTickets)
        self.viwRewardPopup.showDefaultData(data: data[4], type: .vouchersAndOffers)
    }
    @IBAction func buttonContinue(_ sender: Any) {
        self.viwRewardPopup.isHidden = true
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
            viewTimerSection.isHidden = false
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
      //  let sec = time/1000
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
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
        counter = (self.rewardResponse?.data.hurryUpSection.timeLeft ?? 0)/1000
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showTimerWithAnimation()
        }
    }
    private func initUI() {
        viewTimerSection.isHidden = true
        viewTimerSection.setGradientBackground(colorTop: UIColor.init(hex: "452735"), colorBottom: UIColor.init(hex: "221E2F"))
        labelTimerText.gradientColors = [UIColor(hex: "FFC2C2").cgColor, UIColor(hex: "FF8585").cgColor]
        viewBottom.setGradientBackground(colorTop: UIColor(hex: "393D51"), colorBottom: UIColor.init(hex: "14182A"))
        buttonContinue.setUpButtonWithGradientBackground(type: .yellow)
        
        designShadowViews()
        tableMyReward.dataSource = self
        createMiddleView()
    }
    private func createMiddleView() {
        viewBetween.isHidden = false

        
        
        
      //  viewBetween.setGradientBackground(colorTop: UIColor(hex: "393D51"), colorBottom: UIColor.init(hex: "14182A"))

//        let availableWidth = viewBetween.frame.width
//        // Set the circle width and spacing
//        let circleWidth: CGFloat = 20
//        let spacing: CGFloat = 5
//
//        // Calculate the number of circles that fit in the width
//        let maxCircles = Int(availableWidth / (circleWidth + spacing))
//        let actualWidth = CGFloat(maxCircles) * circleWidth + CGFloat(maxCircles - 1) * spacing
//
//
//        for i in 0..<maxCircles {
//            let circleView = UIView()
//            if i == 0 {
//                circleView.frame = CGRect(x: 0, y: 0, width: circleWidth, height: 10)
//            } else {
//                circleView.frame = CGRect(x: CGFloat(i*Int(circleWidth)) + spacing, y: 0, width: circleWidth, height: 10)
//            }
//
//            circleView.backgroundColor = UIColor.clear
//            circleView.layer.cornerRadius = 5
//            circleView.clipsToBounds = true
//            viewBetween.addSubview(circleView)
//        }

        
    }
    private func designShadowViews() {
        viewKnowMore.layer.cornerRadius = 11
        viewKnowMore.addShadow(location: .top, color: .lightGray, opacity: 0.5)
        viewTimerSection.layer.cornerRadius = 22
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
        cell.configCell(data: list[indexPath.row], index: indexPath.row )
        return cell
    }
    
    
}
