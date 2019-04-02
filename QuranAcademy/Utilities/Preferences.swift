//
//  Preferences.swift
//  QuranAcademy
//
//  Created by Ayub on 09/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation
import UIKit

final class Preferences {
    
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
            UserDefaults.standard.synchronize()
        }
    }
    
    /// Код смыслового перевода для обращения к базе
    static var translationCode: String {
        get {
            let code = UserDefaults.standard.string(forKey: Keys.kTranslationCode) ?? ""
            return code
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kTranslationCode)
        }
    }
    
    /// Код пословного перевода для обращения к базе
    static var wordTranslationCode: String {
        get {
            let code = UserDefaults.standard.string(forKey: Keys.kWordTranslationCode) ?? ""
            return code
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kWordTranslationCode)
        }
    }

    /// Название выбранного языка для отображения в настройках
    static var language: String {
        get {
            let lng = UserDefaults.standard.string(forKey: Keys.kLanguage) ?? "English"
            return lng
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kLanguage)
        }
    }
    
    /// Название выбранного смыслового перевода для отображения в настройках
    static var translation: String {
        get {
            let transl = UserDefaults.standard.string(forKey: Keys.kTranslation) ?? "Не выбрано"
            return transl
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kTranslation)
        }
    }
    
    /// Название выбранного пословного перевода для отображения в настройках
    static var wordTranslation: String {
        get {
            let wordTransl = UserDefaults.standard.string(forKey: Keys.kWordTranslation) ?? "Не выбрано"
            return wordTransl
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kWordTranslation)
        }
    }
    
    static var arabicFontSize: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.kArabicFontSize)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kArabicFontSize)
        }
    }
    
    static var translationFontSize: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.kTranslationFontSize)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kTranslationFontSize)
        }
    }
    
    static var arabicFont: String {
        get {
            let wordTransl = UserDefaults.standard.string(forKey: Keys.kArabicFont) ?? "me_quran2"
            return wordTransl
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kArabicFont)
        }
    }
    
    static var translationFont: String {
        get {
            let wordTransl = UserDefaults.standard.string(forKey: Keys.kTranslationFont) ?? "Proxima Nova Light"
            return wordTransl
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kTranslationFont)
        }
    }
    
    static var showArabic: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.kArabicEnable)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kArabicEnable)
        }
    }
    
    static var showTranslation: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.kTranslateEnable)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.kTranslateEnable)
        }
    }

    
}
