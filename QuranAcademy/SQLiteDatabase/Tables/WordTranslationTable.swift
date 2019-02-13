//
//  WordTranslationsExpressions.swift
//  QuranAcademy
//
//  Created by Ayub on 04/02/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import SQLite

struct WordTranslationTable {
    
    private let languageCode = Expression<String>("languageCode")
    private let language = Expression<String>("languageName")
    private let fileUrl = Expression<String>("fileUrl")
    private let version = Expression<String>("version")
    private let translationUpdatedAt = Expression<String>("translationUpdatedAt")
    
    func createTable(_ name: String, _ database: Connection) {
        do {
            try database.run(Table(name).create(ifNotExists: true) { table in
                table.column(languageCode)
                table.column(language)
                table.column(fileUrl)
                table.column(version)
                table.column(translationUpdatedAt)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}
