//
//  SQLiteStorage.swift
//  QuranAcademy
//
//  Created by Ayub on 26/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import SQLite

final class SQLiteStorage: SQLiteStorageProtocol {
    
    private var db: Connection?
    private lazy var sura = SuraTable()
    private lazy var language = LanguageTable()
    private lazy var translation = TranslationTable()
    private lazy var wordTranslation = WordTranslationTable()
    var isDatabaseEmpty = false

    
    init(_ type: DatabaseType) {
        do {
            let database = try Connection(type.path)
            db = database
        } catch {
            print(error)
        }
    }
    
    private func add(_ item: Codable, table: Table) -> Int64? {
        do {
            return try db?.run(table.insert(item))
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func objects<T>(_ type: T.Type, table: String) -> [T] where T : Codable {
        var array = [T]()
        
        do {
            array = try db!.prepare(Table("\(table)")).map { row in
                return try row.decode()
            }
        } catch {
            print(error.localizedDescription)
        }
        return array
    }
    
    func objects<T: Codable>(with id: Int, _ type: T.Type, table: String, columnName: String = "sura") -> [T] {
        var array = [T]()
        let columnID = Expression<Int>(columnName)

        do {
            array = try db!.prepare(Table("\(table)").filter(columnID == id)).map { row in
                return try row.decode()
            }
            
        } catch {
            print(error.localizedDescription)
        }
        return array
    }
    
    func save(_ type: [Codable], table: String) {
        for i in type {
            _ = add(i, table: Table("\(table)"))
        }
    }
    
    func createTable(_ name: String, _ type: TableType) {
        switch type {
        case .sura:
            sura.createTable(name, db!)
        case .language:
            language.createTable(name, db!)
        case .translation:
            translation.createTable(name, db!)
        case .wordTranslation:
            wordTranslation.createTable(name, db!)
        case .tafsir:
            print("tafsir")
        }
        
    }
    
    func createListTables() {
        sura.createTable(Tables.sura, db!)
        language.createTable(Tables.language, db!)
        translation.createTable(Tables.translation, db!)
        wordTranslation.createTable(Tables.wordTranslation, db!)
    }
    
}
