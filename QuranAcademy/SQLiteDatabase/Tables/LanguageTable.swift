//
//  LanguagesExpressions.swift
//  QuranAcademy
//
//  Created by Ayub on 04/02/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import SQLite

struct LanguageTable {
    
    let id = Expression<Int>("id")
    let code = Expression<String>("code")
    let name = Expression<String>("name")
    let isRtl = Expression<Bool>("isRtl")
    
    func createTable(_ name: String, _ database: Connection) {
        do {
            try database.run(Table(name).create(ifNotExists: true) { table in
                table.column(id, unique: true)
                table.column(code)
                table.column(self.name)
                table.column(isRtl)
            })
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
