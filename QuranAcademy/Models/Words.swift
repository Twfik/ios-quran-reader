//
//  Words.swift
//  QuranAcademy
//
//  Created by Ayub on 17/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

struct Words {
    let sura: Int
    let ayat: Int
    let text: String
    let order: Int
    
    init(sura: Int, ayat: Int, text: String, order: Int) {
        self.sura = sura
        self.ayat = ayat
        self.text = text
        self.order = order
    }
    
}
