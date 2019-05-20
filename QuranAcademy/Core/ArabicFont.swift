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
    
    static var fontRawValue: Int {
        return ArabicFont.current.rawValue
    }
    
    var font: UIFont {
        let size = UserDefaults.standard.float(forKey: Keys.arabicFontSize)
        switch self {
        case .meQuran:
            return UIFont(name: "me_quran", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
        case .kfgpc:
            return UIFont(name: "KFGQPC Uthmanic Script HAFS", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
        }
    }
    
    var title: String {
        switch self {
        case .meQuran: return "MeQuran"
        case .kfgpc: return "KFGQPC Uthmanic"
        }
    }
    
    static var fontWasChanged = PublishSubject<Void>()
    
    func apply() {
        UserDefaults.standard.set(rawValue, forKey: Keys.arabicFont)
        UserDefaults.standard.synchronize()
        ArabicFont.fontWasChanged.onNext(())
    }
    
    private enum Keys {
        static let arabicFont = "kArabicFont"
        static let arabicFontSize = "kArabicFontSize"
    }

}

enum ArabicFontSize: Int, CaseIterable {
    case xs, s, m, l, xl, xxl, xxxl
    
    private enum Keys {
        static let arabicFontSize = "kArabicFontSize"
    }
    
    static var current: ArabicFontSize {
        let storedFont = UserDefaults.standard.integer(forKey: Keys.arabicFontSize)
        return ArabicFontSize(rawValue: storedFont) ?? .xs
    }
    
    var size: Float {
        switch self {
        case .xs: return 17
        case .s: return 19
        case .m: return 21
        case .l: return 23
        case .xl: return 25
        case .xxl: return 26
        case .xxxl: return 27
        }
    }
    
    static var fontWasChanged = PublishSubject<Void>()
    
    func apply() {
        UserDefaults.standard.set(rawValue, forKey: Keys.arabicFontSize)
        UserDefaults.standard.synchronize()
        ArabicFontSize.fontWasChanged.onNext(())
    }
    
}

