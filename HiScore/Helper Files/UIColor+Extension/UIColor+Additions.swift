//
//  UIColor+Additions.swift
//  JustGame
//
//   
//

import Foundation
import UIKit
extension UIColor {
    /**
     This initializer initialise UIColor from a valid hex color string
     
     *Value*
     
     `hex:` The hex color string from where UIColor instance to be created.
     */
    convenience init (hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if (cString.count) != 6 {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    } 

    static let HSAppThemeColor: UIColor = {
        return UIColor(hex: "#14182B")
    }()
    
    static let HSWhiteColor: UIColor = {
        return UIColor(hex: "#FFFFFF")
    }()

    static let HSLightYellowColor: UIColor = {
        return UIColor(hex: "#E3CEB6")
    }()
    
    static let HSGrayColor: UIColor = {
        return UIColor(hex: "#BCBDC1")
    }()
    
    static let HSDarkGrayColor: UIColor = {
        return UIColor(hex: "#777777")
    }()
    
    static let HSRedColor: UIColor = {
        return UIColor(hex: "#F54D3F")
    }()
    
    static let HSBlackTextColor: UIColor = {
        return UIColor(hex: "#12011F")
    }()
    
    static let HSYellowTextColor: UIColor = {
        return UIColor(hex: "#F3DEB1")
    }()
        
    static let HSGoldenYellowTextColor: UIColor = {
        return UIColor(hex: "#D8B06E")
    }()
    
    static let HSYellowButtonColor: UIColor = {
        return UIColor(hex: "#F5E2B7")
    }()
    
    static let HSDarkYellowButtonColor: UIColor = {
        return UIColor(hex: "#CD9D52")
    }()
        
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    static let HSYellowButtonTextColor: UIColor = {
        return  UIColor(red: 0.07, green: 0, blue: 0.12, alpha: 1)
    }()
    
    static let HSLightGreyButtonTextColor: UIColor = {
        return  UIColor(red: 0.933, green: 0.839, blue: 0.651, alpha: 1)
    }()
    
    static let HSDarkBlue: UIColor = {
        return  UIColor(hex: "#14182B")
    }()
    
    static let HSBlue: UIColor = {
       return UIColor(hex: "#458FFF")
    }()
    
    static let HSGreyBlue: UIColor = {
       return UIColor(hex: "#8393B2")
    }()
    
    static let HSMediumDarkBlue: UIColor = {
       return UIColor(hex: "#393D51")
    }()
    
    static let HSTabbarColor: UIColor = {
        return UIColor(red: 0.094, green: 0.113, blue: 0.204, alpha: 0.8)
    }()
    
//    static let HSBlackTextColor: UIColor = {
//        return UIColor(hex: "#463327")
//    }()
    
    static let HSLightBlackColor: UIColor = {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    }()
    
    static let HSRewardBlackColor: UIColor = {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    }()
}
