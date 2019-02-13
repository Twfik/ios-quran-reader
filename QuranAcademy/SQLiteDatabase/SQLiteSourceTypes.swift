//
//  SQLiteTypes.swift
//  QuranAcademy
//
//  Created by Ayub on 06/02/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import SQLite

enum DatabaseType {
    case quran
    case list
    case tafsir
    case byWord
    
    var path: String {
        let path = FileManager.default.documentsURL
        switch self {
        case .quran: return Bundle.main.path(forResource: "Quran", ofType: "db") ?? ""
        case .list: return "\(path)/Lists.db"
        case .tafsir: return "\(path)/\(Preferences.translationCode).db"
        case .byWord: return "\(path)/\(Preferences.wordTranslationCode).db"
        }
    }
}

enum TableType {
    case language
    case sura
    case translation
    case wordTranslation
    case tafsir
}
