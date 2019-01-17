//
//  WordTranslation.swift
//  QuranAcademy
//
//  Created by Ayub on 14/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

struct WordTranslations: Decodable {
    
    let wordTranslation: [WordTranslation]
    
    enum CodingKeys: String, CodingKey {
        case wordTranslation = "data"
    }
}

struct WordTranslation: Decodable {
    let languageCode: String
    let language: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case languageCode = "language_code"
        case language = "language_name"
        case url = "file_url"
    }
}
