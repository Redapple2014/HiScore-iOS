//
//  User.swift
//  HiScore
//
//  Created by PC-010 on 11/10/22.
//

import Foundation

class User {
    static let shared = User()
    private let userDetailsKey = "hiScoreUser@Details"
    var details: VerifyOtpAndLoginResponseModel? {
        do {
            guard let data = UserDefaults.standard.object(forKey: userDetailsKey) else { return nil }
            guard let user = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) as? VerifyOtpAndLoginResponseModel else { return nil }
            return user
        } catch {
            fatalError("Unarchive error: " + error.localizedDescription)
        }
    }
    private init() { }

    func save(userDetails user: VerifyOtpAndLoginResponseModel) {
        do {
            let userData = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
            UserDefaults.standard.set(userData, forKey: userDetailsKey)
            UserDefaults.standard.synchronize()
        } catch {
            fatalError("Archiving error: " + error.localizedDescription)
        }
    }
}
