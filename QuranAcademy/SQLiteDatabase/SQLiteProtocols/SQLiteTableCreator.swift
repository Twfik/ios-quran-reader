//
//  SQLiteTableCreator.swift
//  QuranAcademy
//
//  Created by Ayub on 15/02/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

protocol SQLiteTableCreator {
    func createTable(_ type: SQLiteModel.Type)
}
