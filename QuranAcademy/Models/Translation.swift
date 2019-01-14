//
//  Translation.swift
//  QuranAcademy
//
//  Created by Ayub on 14/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

struct Translations: Decodable {
    
    let translations: [Translation]
    enum CodingKeys: String, CodingKey {
        case translations = "data"
    }
    
}

struct Translation: Decodable {
    
    let id: Int
    let code: String
    let author: String
    let order: Int
    let isTafsir: Bool
    let lngCode: String
    let version: String
    let url: String
    let translationUpdatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case code
        case author = "name"
        case order
        case isTafsir = "is_tafseer"
        case lngCode = "language_code"
        case version
        case url = "file_url"
        case translationUpdatedAt = "translation_updated_at"
    }
    
}
