//
//  SuraExpressions.swift
//  QuranAcademy
//
//  Created by Ayub on 04/02/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import SQLite


struct SuraTable: SQLiteTableCreator {
    
    private let id = Expression<Int>("id")
    private let suraNumber = Expression<Int>("suraNumber")
    private let ayatCount = Expression<Int>("ayatCount")
    private let juzNum = Expression<Int>("juzNum")
    private let hizbNum = Expression<Int>("hizbNum")
    private let rubNum = Expression<Int>("rubNum")
    private let showBasmala = Expression<Bool>("showBasmala")
    private let arabic = Expression<String>("arabic")
    private let translation = Expression<String>("translation")
    private let transliteration = Expression<String>("transliteration")
    
    func createTable(_ type: SQLiteModel.Type) {
        do {
            try Connection(type.path).run(Table(type.table).create(ifNotExists: true) { table in
                table.column(id, unique: true)
                table.column(suraNumber)
                table.column(ayatCount)
                table.column(juzNum)
                table.column(hizbNum)
                table.column(rubNum)
                table.column(showBasmala)
                table.column(arabic)
                table.column(translation)
                table.column(transliteration)
            })
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
