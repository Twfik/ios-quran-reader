//
//  Constants.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

let BASE_URL = "https://api.quranacademy.org/"

enum Keys {
    static let kInstallationID = "kInstallationID"
    static let kLocaleCode = "kLocaleCode"
    static let kTranslationCode = "kTranslationCode"
    static let kWordTranslationCode = "kWordTranslationCode"
    static let isСonfigured = "isСonfigured"
    static let kLanguage = "kLanguage"
    static let kTranslation = "kTranslation"
    static let kWordTranslation = "kWordTranslation"
}

/// Энум для удобного об
enum Tables {
        
    static var language: String {
        return "Languagе"
    }
    static var sura: String {
        return "Sura_\(Preferences.code)"
    }
    static var translation: String {
       return "Translation_\(Preferences.code)"
    }
    static var wordTranslation: String {
        return "WordTranslation_\(Preferences.code)"
    }
    static var ayat: String {
        return "ayats"
    }
    static var words: String {
        return "words"
    }
    static var tafsir: String {
        return "translation"
    }
}
