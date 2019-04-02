//
//  SQLiteStorage.swift
//  QuranAcademy
//
//  Created by Ayub on 26/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import SQLite

final class SQLiteStorage: SQLiteStorageProtocol {
    
    private func add<T: SQLiteModel>(_ item: T) -> Int64? {
        let path = type(of: item).path
        let name = type(of: item).table
        do {
            return try Connection(path).run(Table(name).insert(item))
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func objects<T: SQLiteModel>(_ type: T.Type) -> [T] {
        var array = [T]()
        
        do {
           try DispatchQueue.global(qos: .userInteractive).sync {
                array = try Connection(type.path).prepare(Table(type.table)).map { row in
                    return try row.decode()
            }
            }
        } catch {
            print(error.localizedDescription)
        }
        return array
    }
    
    func objects<T: SQLiteModel>(with id: Int, _ type: T.Type, columnName: String = "sura") -> [T] {
        var array = [T]()
        let columnID = Expression<Int>(columnName)

        do {
           try DispatchQueue.global(qos: .userInteractive).sync {
                array = try Connection(type.path).prepare(Table(type.table).filter(columnID == id)).map { row in
                    return try row.decode()
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
        return array
    }
    
    func save<T: SQLiteModel>(_ types: [T]) {
        for i in types {
            _ = add(i)
        }
    }
    
    func createTable<T: SQLiteModel>(_ type: T.Type) {
        type.tableCreator?.createTable(type)
    }

    
    func createListTables() {
        createTable(SuraCodable.self)
        createTable(Language.self)
        createTable(Translation.self)
        createTable(WordTranslation.self)
    }
    
}
