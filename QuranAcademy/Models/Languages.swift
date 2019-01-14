//
//  LanguagesJSON.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

struct Languages: Decodable {
    let languages: [Language]
}

struct Language: Decodable {
    let id: Int
    let code: String
    let name: String
    let is_rtl: Bool
    
    enum CodingKeys : String, CodingKey {
        case id
        case code
        case name
        case is_rtl = "is_rtl"
    }
    
}
