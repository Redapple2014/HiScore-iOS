//
//  UIFont+Additions.swift
//  JustGame
//
//  b/Users/pc-043/Documents/IOS/JustGame-IOS/JustGame/Helper/UIFont+Extension/UIFont+Additions.swift
//

import UIKit
extension UIFont {
    struct Rajdhani {
        static let Bold: UIFont = {
            return UIFont(name: FontsIdentifier.RajdhaniBold, size: 15) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let Light: UIFont = {
            return UIFont(name: FontsIdentifier.RajdhaniLight, size: 15) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let Medium: UIFont = {
            return UIFont(name: FontsIdentifier.RajdhaniMedium, size: 15) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let Regular: UIFont = {
            return UIFont(name: FontsIdentifier.RajdhaniRegular, size: 15) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let SemiBold: UIFont = {
            return UIFont(name: FontsIdentifier.RajdhaniSemiBold, size: 15) ?? UIFont.systemFont(ofSize: 13)
        }()
    }
    struct MavenPro {
        static let Black: UIFont = {
            return UIFont(name: FontsIdentifier.MavenProBlack, size: 16) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let Bold: UIFont = {
            return UIFont(name: FontsIdentifier.MavenProBold, size: 16) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let ExtraBold: UIFont = {
            return UIFont(name: FontsIdentifier.MavenProExtraBold, size: 16) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let Medium: UIFont = {
            return UIFont(name: FontsIdentifier.MavenProMedium, size: 16) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let Regular: UIFont = {
            return UIFont(name: FontsIdentifier.MavenProRegular, size: 16) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let SemiBold: UIFont = {
            return UIFont(name: FontsIdentifier.MavenProSemiBold, size: 16) ?? UIFont.systemFont(ofSize: 13)
        }()
    }

    struct Baloo {
        static let Bold: UIFont = {
            return UIFont(name: FontsIdentifier.Baloo2Bold, size: 16) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let ExtraBold: UIFont = {
            return UIFont(name: FontsIdentifier.Baloo2ExtraBold, size: 16) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let Medium: UIFont = {
            return UIFont(name: FontsIdentifier.Baloo2Medium, size: 16) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let Regular: UIFont = {
            return UIFont(name: FontsIdentifier.Baloo2Regular, size: 16) ?? UIFont.systemFont(ofSize: 13)
        }()
        static let SemiBold: UIFont = {
            return UIFont(name: FontsIdentifier.Baloo2SemiBold, size: 16) ?? UIFont.systemFont(ofSize: 13)
        }()

    }
}
struct FontsIdentifier {
    static let RajdhaniBold  = "Rajdhani-Bold"
    static let RajdhaniLight = "Rajdhani-Light"
    static let RajdhaniMedium = "Rajdhani-Medium"
    static let RajdhaniRegular = "Rajdhani-Regular"
    static let RajdhaniSemiBold = "Rajdhani-SemiBold"
    static let MavenProBlack = "MavenPro-Black"
    static let MavenProBold = "MavenPro-Bold"
    static let MavenProExtraBold = "MavenPro-ExtraBold"
    static let MavenProMedium = "MavenPro-Medium"
    static let MavenProRegular = "MavenPro-Regular"
    static let MavenProSemiBold = "MavenPro-SemiBold"

    static let Baloo2Bold = "Baloo2-Bold"
    static let Baloo2ExtraBold = "Baloo2-ExtraBold"
    static let Baloo2Medium = "Baloo2-Medium"
    static let Baloo2Regular = "Baloo2-Regular"
    static let Baloo2SemiBold = "Baloo2-SemiBold"

}
