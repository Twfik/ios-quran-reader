//
//  SuraDetailViewModel.swift
//  QuranAcademy
//
//  Created by Ayub on 13/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

enum QuranCellType: Int, CaseIterable {
    case arabic
    case translation
}

final class SuraDetailViewModel {
    
    let showBasmala: Bool
    let sura: Sura
    var ayats: [Ayat] = []
    var translations: [Tafsir] = []
    var cellModels = QuranCellType.allCases
    
    init(sura: Sura) {
        self.sura = sura
        self.showBasmala = sura.showBasmala
        
        self.ayats = SQLiteStorage().objects(with: sura.id, Ayat.self)
        DispatchQueue.global(qos: .userInteractive).sync {
        }
        
        DispatchQueue.global(qos: .userInteractive).sync {
            self.translations = SQLiteStorage().objects(with: sura.id, Tafsir.self)
        }
        
    }
    
}
