//
//  FontSettings.swift
//  QuranAcademy
//
//  Created by Ayub on 16/05/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import RxSwift

enum ArabicFont: Int, CaseIterable {
    case meQuran, kfgpc
    
    static var current: ArabicFont {
        let storedFont = UserDefaults.standard.integer(forKey: Keys.arabicFont)
        return ArabicFont(rawValue: storedFont) ?? .meQuran
    }
    
    var font: UIFont {
        let size = UserDefaults.standard.float(forKey: Keys.arabicFontSize)
        switch self {
        case .meQuran:
            return UIFont(name: "me_quran2", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
        case .kfgpc:
            return UIFont(name: "KFGQPC Uthmanic Script HAFS", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
        }
    }
    
    var title: String {
        switch self {
        case .meQuran: return "Шрифт 1"
        case .kfgpc: return "Шрифт 2"
        }
    }
    
    static var fontWasChanged = PublishSubject<Void>()
    
    func apply() {
        UserDefaults.standard.set(rawValue, forKey: Keys.arabicFont)
        UserDefaults.standard.synchronize()
        ArabicFont.fontWasChanged.onNext(())
    }
    
    private enum Keys {
        static let arabicFontSize = "kArabicFontSize"
        static let arabicFont = "kArabicFont"
    }

}

enum TranslationFonts: CaseIterable {
    static var proximaNova = "Proxima Nova"
    static var georgia = "Georgia"
    static var palatino = "Palatino"
    
    private enum Keys {
        static let translationFontSize = "kTranslationFontSize"
        static let translationFont = "kTranslationFont"
    }
    
}

struct FontSettings {
    private enum Keys {
        static let arabicFontSize = "kArabicFontSize"
        static let translationFontSize = "kTranslationFontSize"
        static let arabicFont = "kArabicFont"
        static let translationFont = "kTranslationFont"
    }
    
    static var currentArabicFontSize: Float {
        return UserDefaults.standard.float(forKey: Keys.arabicFontSize)
    }
    
    static var currentTranslationFontSize: Float {
        return UserDefaults.standard.float(forKey: Keys.translationFontSize)
    }
    
    static var currentArabicFont: UIFont {
        let fontName = UserDefaults.standard.string(forKey: Keys.arabicFont) ?? ""
        let size = FontSettings.currentArabicFontSize
        return UIFont(name: fontName, size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    static var currentTranslationFont: String {
        return UserDefaults.standard.string(forKey: Keys.translationFont) ?? ""
    }
    
    func apply() {
        
    }

    
}
