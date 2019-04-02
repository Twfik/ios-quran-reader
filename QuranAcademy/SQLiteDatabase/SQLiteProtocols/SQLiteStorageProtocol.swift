//
//  Storage.swift
//  QuranAcademy
//
//  Created by Ayub on 26/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation
import SQLite

protocol SQLiteStorageProtocol {
    func objects<T: SQLiteModel>(_ type: T.Type) -> [T]
    func objects<T: SQLiteModel>(with id: Int, _ type: T.Type, columnName: String) -> [T]
    func save<T: SQLiteModel>(_ type: [T])
    func createTable<T: SQLiteModel>(_ type: T.Type)
}
