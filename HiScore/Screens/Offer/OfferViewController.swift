//
//  OfferViewController.swift
//  HiScore
//
//  Created by RATPC-043 on 22/08/23.
//

import Foundation
import UIKit
import MHLoadingButton

class OfferViewController: BaseViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var viewTimer: UIView!
    @IBOutlet weak var labelTimer: GradientLabel!
    @IBOutlet weak var labelTimerDescription: UILabel!
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var labelSubHeader: UILabel!
    @IBOutlet weak var buttonStartPlaying: LoadingButton!
    @IBOutlet weak var collectionViewOffer: UICollectionView!
    
    @IBOutlet weak var viewTopConstraintWithSafeArea: NSLayoutConstraint!
    @IBOutlet weak var viewTopConstraintWithTimerView: NSLayoutConstraint!
    
    private var viewModel: OfferViewModel!
    private var offer: OffersSection?
    private var time = 0
    private var timer: Timer?
}
//MARK: - View life cycles
extension OfferViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let hiScoreNetworkService = HiScoreNetworkRepository()
        viewModel = OfferViewModel(networkService: hiScoreNetworkService)
       
        buttonStartPlaying.addTarget(self, action: #selector(startPlayingDidTap), for: .touchUpInside)
        viewTimer.setCornerBorder(color: .HSDarkRed,
                                  cornerRadius: 25,
                                  borderWidth: 0.8)
        labelTimer.gradientColors = [UIColor.HSPinkColor.cgColor,
                                     UIColor.HSLightRed.cgColor]
        viewTimer.setGradiantColor(topColor: UIColor.HSDarkRed,
                                   bottomColor: UIColor.HSBlackColor,
                                   gradiantDirection: .rightToLeft)
        viewTopConstraintWithSafeArea.isActive = true
        viewTopConstraintWithTimerView.isActive = false
        viewTimer.isHidden = true
        getOfferDetails()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttonStartPlaying.setNeedsLayout()
        buttonStartPlaying.layoutIfNeeded()
        buttonStartPlaying.setCornerBorder(color: .HSYellowButtonColor,
                                         cornerRadius: 10,
                                         borderWidth: 0.8)
        buttonStartPlaying.setUpButtonWithGradientBackground(type: .yellow)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
    }
}

//MARK: - Collection delegates and datasource
extension OfferViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = offer?.offers else { return 0}
        return data.count
        //  return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewOffer.dequeueReusableCell(withReuseIdentifier: "OfferCollectionCell", for: indexPath) as? OfferCollectionCell else {
            return OfferCollectionCell(frame: .zero)
        }
        if  let data = offer?.offers {
            cell.offer = data[indexPath.item]
        }
        //        let url = URL(string: "https://cdn-images.nst-app.com/img/Game/Login_screen/new_login/offer1@3x.png")
        //        cell.imageViewOffer.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        //        cell.labelButtonText.text = "$1-$99"
        return cell
    }
}
//MARK: - Collection flow layout delegates
extension OfferViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 6
        return CGSize(width: width, height: width * 1.3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

//MARK: - Private Methods
private extension OfferViewController {
    @objc func startPlayingDidTap(){
        guard let viewController = self.storyboard(name: .home).instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController else {
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func getOfferDetails() {
        viewModel.getOfferDetails { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    Log.d(response)
                    guard let offerData = response.data else { return }
                    self.offer = offerData.offersSection
                    self.labelHeader.text = offerData.greetingSection.greetingTitle.en
                    self.labelSubHeader.text = offerData.greetingSection.greetingSubtitle.en
                    self.labelTimerDescription.text = offerData.hurryUpSection.hurryTitle.en
                    self.collectionViewOffer.reloadData()
                    sleep(2)
                    self.time = offerData.hurryUpSection.timeLeft/1000
                    self.labelTimer.text = self.setTimer(timerValue: self.time)
                    self.unhideAndAnimateViewAppearFromTop()
                    self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                                      target: self,
                                                      selector: #selector(self.updateTimer),
                                                      userInfo: nil,
                                                      repeats: true)
                case .failure(let error):
                    Log.d(error)
                }
            }
        }
    }
    func setTimer(timerValue: Int) -> String {
        let sec = timerValue
        let hours = sec / 3600
        let minutes = (sec % 3600) / 60
        let seconds = sec % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    @objc func updateTimer() {
        if time > -1 {
            if time == 0 {
                stopTimer()
                unhideAndAnimateViewAppearFromBottom()
            } else {
                let value = self.setTimer(timerValue: time)
                self.labelTimer.text = value
                Log.d("\(value) seconds to left")
            }
            time = time - 1
        } else {
            stopTimer()
        }
    }
    func unhideAndAnimateViewAppearFromTop() {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        viewTimer.layer.add(transition, forKey: kCATransition)
        self.viewTimer.isHidden = false
        self.viewTopConstraintWithSafeArea.isActive = false
        self.viewTopConstraintWithTimerView.isActive = true
    }
    func unhideAndAnimateViewAppearFromBottom() {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        viewTimer.layer.add(transition, forKey: kCATransition)
        self.viewTimer.isHidden = true
        self.viewTopConstraintWithSafeArea.isActive = true
        self.viewTopConstraintWithTimerView.isActive = false
    }
}
