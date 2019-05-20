//
//  Ayats.swift
//  QuranAcademy
//
//  Created by Ayub on 17/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

struct Ayat: SQLiteModel {
    
    static var tableCreator: SQLiteTableCreator? = nil
    static var table: String {
        return Tables.ayat
    }
    
    static var path: String {
        return DatabaseType.quran.path
    }
    let sura: Int
    let ayat: Int
    let text: String
    let text_tajweed: String
}

