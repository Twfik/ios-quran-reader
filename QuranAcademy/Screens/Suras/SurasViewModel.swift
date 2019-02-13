//
//  SurasViewModel.swift
//  QuranAcademy
//
//  Created by Ayub on 22/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

final class SurasViewModel {
    
    var suras = [Sura]()
    
    init() {
        updateSuras()
    }
    
    @objc func updateSuras() {
        suras = []
        suras = SQLiteStorage(.list).objects(Sura.self, table: Tables.sura)
    }
    
}
