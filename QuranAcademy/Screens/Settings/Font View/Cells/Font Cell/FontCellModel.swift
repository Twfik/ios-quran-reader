//
//  FontCellModel.swift
//  QuranAcademy
//
//  Created by Ayub on 03/05/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

struct FontCellModel: FontCellModelProtocol {
    
    var fontName: String
    var currentFont: String
    var arabicFont: ArabicFont?
    var translationFont: TranslationFont?
    
    init(fontName: String, currentFont: String) {
        self.fontName = fontName
        self.currentFont = currentFont
    }
    
    func applyArabicFont() {
        ArabicFont.current.apply()
    }
    
}
