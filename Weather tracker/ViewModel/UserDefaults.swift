//
//  UserDefaults.swift
//  Weather tracker
//
//  Created by Misha on 12.11.2021.
//

import Foundation

class WelcomeCore {

    static let shared = WelcomeCore()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }

    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }

}
