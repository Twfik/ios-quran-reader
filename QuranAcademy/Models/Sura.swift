//
//  Suras.swift
//  QuranAcademy
//
//  Created by Ayub on 12/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

struct SurasResponse: Codable {
    let suras: [SuraCodable]
    
    enum CodingKeys: String, CodingKey {
        case suras = "data"
    }
}

struct Sura: Codable {
    let id: Int
    let suraNumber: Int
    let ayatCount: Int
    let juzNum: Int
    let hizbNum: Int
    let rubNum: Int
    let showBasmala: Bool
    let arabic: String
    let translation: String
    let transliteration: String
}

struct SuraCodable: Codable {
    let id: Int
    let suraNumber: Int
    let ayatCount: Int
    let juzNum: Int
    let hizbNum: Int
    let rubNum: Int
    let showBasmala: Bool
    let arabic: String
    let translation: String
    let transliteration: String
    
    enum SuraKeys: String, CodingKey {
        case id
        case suraNumber
        case ayatCount
        case juzNum
        case hizbNum
        case rubNum
        case showBasmala
        case name
    }
    
    enum SuraDesripKeys: String, CodingKey {
        case arabic
        case translation
        case transliteration
    }
    
    // Этот инициализатор пришлось сделать из-за того, что SQLite не записывает вложенные типы
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SuraKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.suraNumber = try container.decode(Int.self, forKey: .suraNumber)
        self.ayatCount = try container.decode(Int.self, forKey: .ayatCount)
        self.juzNum = try container.decode(Int.self, forKey: .juzNum)
        self.rubNum = try container.decode(Int.self, forKey: .rubNum)
        self.hizbNum = try container.decode(Int.self, forKey: .hizbNum)
        self.showBasmala = try container.decode(Bool.self, forKey: .showBasmala)
        
        // Nested container
        let suraDesripContainer = try container.nestedContainer(keyedBy: SuraDesripKeys.self, forKey: .name)
        self.arabic = try suraDesripContainer.decode(String.self, forKey: .arabic)
        self.translation = try suraDesripContainer.decode(String.self, forKey: .translation)
        self.transliteration = try suraDesripContainer.decode(String.self, forKey: .transliteration)
    }
}
