//
//  Typable.swift
//  QuranAcademy
//
//  Created by Ayub on 13/02/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

protocol SQLiteModel: Codable {
    static var path: String { get }
    static var table: String { get }
    static var tableCreator: SQLiteTableCreator? { get }
}
