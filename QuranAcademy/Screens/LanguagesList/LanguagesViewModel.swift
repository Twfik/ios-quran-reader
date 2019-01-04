//
//  LanguagesViewModel.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

struct LanguagesViewModel {
    
    var languages: [LanguagesJSON]
    
    init(languages: [LanguagesJSON]) {
        self.languages = languages
    }
    
}
