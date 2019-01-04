//
//  Constants.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

let BASE_URL = "https://api.quranacademy.org/"

var installationID: String {
    if UserDefaults.standard.string(forKey: Keys.kInstallationID) == nil {
        let uuid = UUID().uuidString
        UserDefaults.standard.set(uuid, forKey: Keys.kInstallationID)
    }
    return UserDefaults.standard.string(forKey: Keys.kInstallationID) ?? ""
}

enum Keys {
    static let kInstallationID = "kInstallationID"
}
