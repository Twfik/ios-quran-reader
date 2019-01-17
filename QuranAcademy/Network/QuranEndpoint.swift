//
//  QuranEndpoint.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Moya

enum QuranEndpoint {
    case getLanguages
    case getQuranTextURL
    case getSuras
    case getSurasTranslations
    case getTranslationsAndTafsirs
    case getWordByWordTranslations
}

extension QuranEndpoint: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .getLanguages: return "languages"
        case .getQuranTextURL: return "quran/arabic-text"
        case .getSuras: return "quran/suras"
        case .getSurasTranslations: return "quran/suras/name-translations"
        case .getTranslationsAndTafsirs: return "quran/translations?format_version=1"
        case .getWordByWordTranslations: return "quran/word-by-word-translations"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["InstallationId" : "\(Preferences.installationID)",
            "Content-Type" : "application/json",
            "Locale" : "\(Preferences.code)"
        ]
    }
    
}
