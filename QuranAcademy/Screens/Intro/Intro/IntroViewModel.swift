//
//  LanguagesViewModel.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Moya

struct IntroViewModel {
    
    var languages: [LanguagesJSON]
    var provider: MoyaProvider<QuranEndpoint>
    
    init(languages: [LanguagesJSON], provider: MoyaProvider<QuranEndpoint>) {
        self.languages = languages
        self.provider = provider
    }
    
    
}
