//
//  LanguagesJSON.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

struct LanguagesResponse: Codable {
    
    let languages: [Language]
    
    init(languages: [Language]) {
        self.languages = languages
    }
}

struct Language: SQLiteModel {
    
    static var tableCreator: SQLiteTableCreator? = LanguageTable()
    
    static var table: String {
        return Tables.language
    }
    
    static var path: String {
        return DatabaseType.list.path
    }
    
    let id: Int
    let code: String
    let name: String
    let isRtl: Bool
}
