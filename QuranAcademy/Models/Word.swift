//
//  Words.swift
//  QuranAcademy
//
//  Created by Ayub on 17/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

struct Word: SQLiteModel {
    
    static var tableCreator: SQLiteTableCreator? = nil
    static var table: String {
        return Tables.words
    }

    static var path: String {
        return DatabaseType.byWord.path
    }
    let sura: Int
    let ayat: Int
    let text: String
    let order: Int
}
