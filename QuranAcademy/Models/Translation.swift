//
//  Translation.swift
//  QuranAcademy
//
//  Created by Ayub on 14/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

struct TranslationsResponse: Codable {
    
    let translations: [Translation]
    enum CodingKeys: String, CodingKey {
        case translations = "data"
    }
    
}

struct Translation: SQLiteModel {
    
    static var tableCreator: SQLiteTableCreator? = TranslationTable()
    static var table: String {
        return Tables.translation
    }

    static var path: String {
        return DatabaseType.list.path
    }
    
    
    
    let id: Int
    let code: String
    let name: String
    let order: Int
    let isTafseer: Bool
    let languageCode: String
    let version: String
    let translationUpdatedAt: String
    let fileUrl: String
}
