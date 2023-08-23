//
//  String+Extension.swift
//  HiScore
//
//  Created by Sandeep Nag on 19/08/23.
//

import Foundation

extension String {
    var validateOTP: Bool {
        if self.count == 6 {
            return true
        } else {
            return false
        }
    }
    var validatePhoneNumber: Bool {
        if self.isEmpty {
            return false
        } else if self.count < 10 {
            return false
        } else {
            return true
        }
    }
    var validateUUID: Bool {
        self.isEmpty ? true : false
    }
}

