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
}

extension RewardPopupViewController {
    @IBAction func buttonContinue(_ sender: Any) {
        
    }
    
}
extension RewardPopupViewController {
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
    private func showText() {
        guard let data = self.rewardResponse?.data else { return }
        labelGreetingText.text = data.greetingSection.subtitle
        labelMObileNUmber.text = "Hi usr\(data.greetingSection.username)"
        labelRewardSubTitle.text = data.rewardSection.totalRewardSubtitle
        labelRewardAmount.text = "₹ \(data.rewardSection.totalRewardReceived)"
        labelHurryUP.text = data.hurryUpSection.hurrySubtitle
        tableMyReward.reloadData()
    }
    private func initUI() {
        viewTimerSection.setGradientBackground(colorTop: UIColor.init(hex: "452735"), colorBottom: UIColor.init(hex: "221E2F"))
        labelTimerText.gradientColors = [UIColor(hex: "FFC2C2").cgColor, UIColor(hex: "FF8585").cgColor]
        viewTop.setGradientBackground(colorTop: UIColor.init(hex: "272B40"),colorBottom: UIColor.init(hex: "181C31"))
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
        
     //   viewBetween.backgroundColor = .blue
//        let stroke = UIView()
//        stroke.bounds = viewBetween.bounds.insetBy(dx: -2, dy: -2)
//        stroke.center = viewBetween.center
//        viewBetween.addSubview(stroke)
//        stroke.bounds = viewBetween.bounds.insetBy(dx: -2, dy: -2)
//        stroke.layer.borderWidth = 4
//        stroke.layer.borderColor = UIColor(red: 0.078, green: 0.094, blue: 0.169, alpha: 1).cgColor
    }
}
extension RewardPopupViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rewardResponse?.data.knowMoreSection.rewardsList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MyRewardsTableViewCell else {
            return MyRewardsTableViewCell()
        }
        guard let res = self.rewardResponse,
              let data = res.data as? RewardDataClass,
              let knowMore = data.knowMoreSection as? KnowMoreSection,
              let list = knowMore.rewardsList as? [RewardsList] else { return MyRewardsTableViewCell()}
        
        cell.configCell(data: list[indexPath.row] )
        return cell
    }
    
    
}
