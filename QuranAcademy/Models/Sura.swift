//
//  Suras.swift
//  QuranAcademy
//
//  Created by Ayub on 12/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

struct SurasResponse: Decodable {
    let suras: [Sura]
    
    enum CodingKeys: String, CodingKey {
        case suras = "data"
    }
}

struct Sura: Decodable {
    let id: Int
    let suraNumber: Int
    let ayatCount: Int
    let juzNum: Int
    let hizbNum: Int
    let rubNum: Int
    let showBasmala: Bool
    let name: SuraName
}

struct SuraName: Decodable {
    let arabic: String
    let translation: String
    let transliteration: String
}
