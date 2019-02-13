//
//  WordTranslation.swift
//  QuranAcademy
//
//  Created by Ayub on 14/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

struct WordTranslationsResponse: Codable {
    
    let wordTranslations: [WordTranslation]
    
    enum CodingKeys: String, CodingKey {
        case wordTranslations = "data"
    }
}

struct WordTranslation: Codable {
    
    let languageCode: String
    let languageName: String
    let fileUrl: String
    let version: String
    let translationUpdatedAt: String
}
