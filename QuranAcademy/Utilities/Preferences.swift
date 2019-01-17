//
//  Preferences.swift
//  QuranAcademy
//
//  Created by Ayub on 09/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

struct Preferences {
    
    /// Уникальный идентификатор установки, меняется при переустановке приложения
    static var installationID: String {
        if UserDefaults.standard.string(forKey: Keys.kInstallationID) == nil {
            let uuid = UUID().uuidString
            UserDefaults.standard.set(uuid, forKey: Keys.kInstallationID)
        }
        return UserDefaults.standard.string(forKey: Keys.kInstallationID) ?? ""
    }
    
    /// Код языка передается в заголовке "Locale" каждого запроса
    static var code: String {
        get {
            let lngCode = UserDefaults.standard.string(forKey: Keys.kLocaleCode) ?? "en"
            return lngCode
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kLocaleCode)
        }
    }
    
}
