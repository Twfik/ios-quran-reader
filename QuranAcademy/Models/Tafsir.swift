//
//  Tafsir.swift
//  QuranAcademy
//
//  Created by Ayub on 15/02/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

class Tafsir: SQLiteModel {
    
    static var tableCreator: SQLiteTableCreator? = nil
    
    static var table: String {
        return Tables.tafsir
    }
    
    static var path: String {
        return DatabaseType.tafsir.path
    }
    let sura: Int
    let ayat: Int
    let text: String
}
