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
    func objects<T: Codable>(_ type: T.Type, table: String) -> [T]
    func objects<T: Codable>(with id: Int, _ type: T.Type, table: String, columnName: String) -> [T]
    func save(_ type: [Codable], table: String)
    func createTable(_ name: String, _ type: TableType)
}
