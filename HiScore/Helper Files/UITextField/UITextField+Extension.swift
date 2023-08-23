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
        self.fieldBorderWidth = 2
        self.defaultBorderColor = .HSTextFieldBorderColor
        self.filledBorderColor = .HSTextFieldBorderColor
        self.cursorColor = UIColor.white
        self.displayType = .square
        self.fieldSize = 42
        self.separatorSpace = 10
        self.displayType = .roundedCorner
        self.fieldFont = UIFont.Rajdhani.Bold.withSize(25)
        self.shouldAllowIntermediateEditing = false
        self.errorBorderColor = .HSRedColor
        UITextField.appearance().keyboardAppearance = UIKeyboardAppearance.light
        self.initializeUI()
    }
}
