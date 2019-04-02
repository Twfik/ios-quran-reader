//
//  Fonts.swift
//  QuranAcademy
//
//  Created by Ayub on 08/02/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

enum QuranFonts: String {
    case me_quran = "me_quran"
    case me_quran2 = "me_quran2"
    case hafs = "KFGQPCScriptHAFS"
        
    var font: UIFont {
        let size = CGFloat(Preferences.arabicFontSize)
        switch self {
        case .me_quran:
            return UIFont(name: "me_quran", size: size) ?? UIFont.systemFont(ofSize: size)
        case .me_quran2:
            return UIFont(name: "me_quran2", size: size) ?? UIFont.systemFont(ofSize: size)
        case .hafs:
            return UIFont(name: "KFGQPCScriptHAFS", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}

enum TextFonts {
    case coconLight, proxima
}
