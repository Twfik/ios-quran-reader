//
//  Font.swift
//  QuranAcademy
//
//  Created by Ayub on 14/02/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum FontType: String {
        case none = "", regular, bold, demibold, light, ultralight, italic, thin, roman, medium, mediumitalic, condensedMedium, condensedExtrabold, semibold, bolditalic, heavy
    }
    
    enum FontFamily: String {
        case georgia = "Georgia"
        case iowan = "IowanOldStyle"
        case palatino = "Palatino"
        case times = "TimesNewRomanPS"
        
        static var all: [FontFamily] = [.georgia, .iowan, .palatino, .times]
        
        func suffix(for type: FontType) -> String {
            switch type {
            case .regular where self == .iowan || self == .palatino: return "-Roman"
            case .regular where self == .times: return "MT"
            case .italic where self == .times, .bold where self == .times: return "-\(type.rawValue.capitalized)MT"
            case .regular where self == .georgia: return ""
            default: return "-\(type.rawValue.capitalized)"
            }
        }
        
        var title: String {
            switch self {
            case .times: return "Times New Roman"
            default: return rawValue
            }
        }
        
    }
    
    static func customFont(of family: FontFamily, type: FontType, size: CGFloat) -> UIFont {
        let name = family.rawValue + family.suffix(for: type)
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}
