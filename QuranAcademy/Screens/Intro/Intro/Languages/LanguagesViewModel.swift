//
//  LanguagesViewModel.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa
import RxSwiftExt

struct LanguagesViewModel {
    
    var languages = [Language]()
    var containerViewModel = ContainerViewModel()
    
    private let provider =  MoyaProvider<QuranEndpoint>()
    private let db = SQLiteStorage(.list)
    
    init() {
        languages = db.objects(Language.self, table: Tables.language)
    }
    
    func getAll() -> Observable<([Language], [Translation], [WordTranslation], [SuraCodable])> {
        if db.objects(Sura.self, table: Tables.sura).isEmpty {
        return containerViewModel
            .getIntroItems()
            .retry(5)
            .asObservable()
            .map { ($0.0, $0.1, $0.2, $0.3) }
        } else {
            let sura: [SuraCodable] = db.objects(SuraCodable.self, table: Tables.sura)
            let language: [Language] = db.objects(Language.self, table: Tables.language)
            let translation: [Translation] = db.objects(Translation.self, table: Tables.translation)
            let wordTranslation: [WordTranslation] = db.objects(WordTranslation.self, table: Tables.wordTranslation)
            return Observable<([Language], [Translation], [WordTranslation], [SuraCodable])>.just((language, translation, wordTranslation, sura))

        }
    }
    
    func getSuras() -> Observable<[SuraCodable]> {
        if db.objects(Sura.self, table: Tables.sura).isEmpty {
            return provider.rx
                .request(.getSuras)
                .filterSuccessfulStatusCodes()
                .debug()
                .retry(3)
                .asObservable()
                .map { $0.data }
                .decode(SurasResponse.self)
                .map { $0.suras }
        } else {
            let sura: [SuraCodable] = db.objects(SuraCodable.self, table: Tables.sura)
            return Observable<[SuraCodable]>.just(sura)
        }
        
        
    }
    
}
