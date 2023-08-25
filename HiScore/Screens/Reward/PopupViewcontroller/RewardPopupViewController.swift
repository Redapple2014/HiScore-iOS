//
//  RewardPopupViewController.swift
//  HiScore
//
//  Created by PC-072 on 21/08/23.
//

import UIKit
import MHLoadingButton
import QuartzCore

class RewardPopupViewController: BaseViewController {
    @IBOutlet weak var labelGreetingText: UILabel!
    @IBOutlet weak var labelMObileNUmber: UILabel!
    @IBOutlet weak var viwRewardPopup: RewardPopupView!
    @IBOutlet weak var tableMyReward: UITableView!
    @IBOutlet weak var labelRewardSubTitle: UILabel!
    @IBOutlet weak var labelRewardAmount: UILabel!
    @IBOutlet weak var labelHurryUP: UILabel!
    @IBOutlet weak var heightOfTable: NSLayoutConstraint!
    @IBOutlet weak var viewBetween: UIView!
    @IBOutlet weak var viewTimerSection: UIView!
    @IBOutlet weak var heightOfTimer: NSLayoutConstraint!
    @IBOutlet weak var viewKnowMore: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var circle1: UIView!
    @IBOutlet weak var circle2: UIView!
    @IBOutlet weak var buttonContinue: LoadingButton!
    @IBOutlet weak var labelTimerText: GradientLabel!
    
    var viewModel: RewardPopupViewModel!
    var rewardResponse: RewardPopupResponseModel?
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
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        invalidTimer()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonContinue.setNeedsLayout()
        buttonContinue.layoutIfNeeded()
        buttonContinue.setUpButtonWithGradientBackground(type: .yellow)
        labelTimerText.gradientColors = [UIColor.HSPinkColor.cgColor,
                                         UIColor.HSLightRed.cgColor]
        viewTimerSection.setCornerBorder(color: .HSDarkRed,
                                         cornerRadius: 25,
                                         borderWidth: 0.8)
        viewTimerSection.setGradiantColor(topColor: UIColor.HSDarkRed,
                                          bottomColor: UIColor.HSBlackColor,
                                          gradiantDirection: .rightToLeft)
        viewBottom.setGradientBackground(colorTop: .HSMediumDarkBlue,
                                         colorBottom: .HSDarkBlue)
    }
}
private extension RewardPopupViewController {
    func getTimeRemainingText(time: Int) -> String {
        //  let sec = time/1000
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func showText() {
        guard let data = self.rewardResponse?.data else { return }
        labelGreetingText.text = data.greetingSection.subtitle
        labelMObileNUmber.text = "Hi \(data.greetingSection.username)"
        labelRewardSubTitle.text = data.rewardSection.totalRewardSubtitle
        labelRewardAmount.text = "₹\(data.rewardSection.totalRewardReceived)"
        labelHurryUP.text = data.hurryUpSection.hurryTitle
        heightOfTable.constant = CGFloat(((self.rewardResponse?.data.rewardSection.allRewards.horizontalSet.count ?? 0) * 56))
        tableMyReward.bounces = false
        tableMyReward.reloadData()
        tableMyReward.delegate = self
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        counter = (self.rewardResponse?.data.hurryUpSection.timeLeft ?? 0)/1000
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showTimerWithAnimation()
        }
    }
    func initUI() {
        viewTimerSection.isHidden = true
        designKnowMoreView()
        tableMyReward.dataSource = self
    }
    func designKnowMoreView() {
        buttonContinue.setUpButtonWithGradientBackground(type: .yellow)
        designShadowViews()
        tableMyReward.dataSource = self
        createDashedLineView()
    }
    private func createDashedLineView() {
        viewBetween.isHidden = false
        let drawDashAtBottom = DashedLineView(frame: CGRect(x: 0,
                                                            y: viewTop.frame.size.height-2,
                                                            width: viewTop.frame.size.width,
                                                            height: 1))
        
        viewTop.addSubview(drawDashAtBottom)
        
        let drawAtTop = DashedLineView(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: viewBottom.frame.size.width,
                                                     height: 1))
        viewBottom.addSubview(drawAtTop)
        
    }
    func designShadowViews() {
        viewKnowMore.layer.cornerRadius = 11
        viewKnowMore.addShadow(location: .top, color: .lightGray, opacity: 0.5)
        viewTimerSection.layer.cornerRadius = 22
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
        guard let viewController = self.storyboard(name: .offer).instantiateViewController(withIdentifier: "OfferViewController") as? OfferViewController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
        
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

extension RewardPopupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
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
        guard let res = self.rewardResponse else {
            return MyRewardsTableViewCell()
        }
        let list = res.data.rewardSection.allRewards.horizontalSet
        cell.configCell(data: list[indexPath.row], index: indexPath.row)
        return cell
    }
}
