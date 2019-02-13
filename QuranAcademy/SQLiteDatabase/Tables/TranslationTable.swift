//
//  TranslationsExpressions.swift
//  QuranAcademy
//
//  Created by Ayub on 04/02/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import SQLite

struct TranslationTable {
    
    private let id = Expression<Int>("id")
    private let order = Expression<Int>("order")
    private let name = Expression<String>("name")
    private let code = Expression<String>("code")
    private let languageCode = Expression<String>("languageCode")
    private let isTafseer = Expression<Bool>("isTafseer")
    private let fileUrl = Expression<String>("fileUrl")
    private let version = Expression<String>("version")
    private let translationUpdatedAt = Expression<String>("translationUpdatedAt")
    
    func createTable(_ name: String, _ database: Connection) {
        do {
            try database.run(Table(name).create(ifNotExists: true) { table in
                table.column(id, unique: true)
                table.column(code)
                table.column(self.name)
                table.column(order)
                table.column(isTafseer)
                table.column(languageCode)
                table.column(fileUrl)
                table.column(version)
                table.column(translationUpdatedAt)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}
