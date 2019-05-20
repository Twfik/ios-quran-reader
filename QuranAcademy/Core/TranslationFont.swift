//
//  TranslationFont.swift
//  QuranAcademy
//
//  Created by Ayub on 16/05/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import RxSwift

enum TranslationFont: Int, CaseIterable {
    case proximaNova, georgia, palatino
    
    static var current: TranslationFont {
        let storedFont = UserDefaults.standard.integer(forKey: Keys.translationFont)
        return TranslationFont(rawValue: storedFont) ?? .proximaNova
    }
    
    static var fontRawValue: Int {
        return TranslationFont.current.rawValue
    }
    
    var font: UIFont {
        let size = UserDefaults.standard.float(forKey: Keys.translationFontSize)
        switch self {
        case .proximaNova:
            return UIFont(name: "Proxima Nova", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
        case .georgia:
            return UIFont(name: "Georgia", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
        case .palatino:
            return UIFont(name: "Palatino", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
        }
    }
    
    var title: String {
        switch self {
        case .proximaNova: return "Proxima Nova"
        case .georgia: return "Georgia"
        case .palatino: return "Palatino"
        }
    }
    
    // Пока не используется, но в будущем при реализации быстрых настроек понадобится
    static var fontWasChanged = PublishSubject<Void>()
    
    func apply() {
        UserDefaults.standard.set(rawValue, forKey: Keys.translationFont)
        UserDefaults.standard.synchronize()
        TranslationFont.fontWasChanged.onNext(())
    }
    
    private enum Keys {
        static let translationFontSize = "kTranslationFontSize"
        static let translationFont = "kTranslationFont"
    }
    
}

enum TranslationFontSize: Int, CaseIterable {
    case xs, s, m, l, xl, xxl, xxxl
    
    private enum Keys {
        static let translationFontSize = "kTranslationFontSize"
    }

    static var current: TranslationFontSize {
        let storedFont = UserDefaults.standard.integer(forKey: Keys.translationFontSize)
        return TranslationFontSize(rawValue: storedFont) ?? .xs
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
        UserDefaults.standard.set(rawValue, forKey: Keys.translationFontSize)
        UserDefaults.standard.synchronize()
        TranslationFontSize.fontWasChanged.onNext(())
    }

}
