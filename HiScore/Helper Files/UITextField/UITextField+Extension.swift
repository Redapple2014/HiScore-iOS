//
//  UITextField+Extension.swift
//  HiScore
//
//  Created by Sandeep Nag on 19/08/23.
//

import Foundation
import OTPFieldView

extension OTPFieldView {
    func setupOTPView() {
        self.fieldsCount = 6
        self.fieldBorderWidth = 0.8
        self.defaultBorderColor = .HSWhiteColor.withAlphaComponent(0.7)
        self.filledBorderColor = .HSWhiteColor.withAlphaComponent(0.7)
        self.cursorColor = UIColor.white
        self.displayType = .square
        self.fieldSize = 48
        self.separatorSpace = 10
        self.displayType = .roundedCorner
        self.fieldFont = UIFont.Rajdhani.Bold.withSize(25)
        self.filledBackgroundColor = .HSWhiteColor.withAlphaComponent(0.1)
        self.defaultBackgroundColor = .HSWhiteColor.withAlphaComponent(0.1)
        self.shouldAllowIntermediateEditing = false
        self.errorBorderColor = .HSRedColor
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.light
        self.initializeUI()
    }
}
