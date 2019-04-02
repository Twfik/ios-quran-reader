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
    private let db = SQLiteStorage()
    
    init() {
        languages = db.objects(Language.self)
    }
    
    func getAll() -> Observable<([Language], [Translation], [WordTranslation], [SuraCodable])> {
        if db.objects(Sura.self).isEmpty {
        return containerViewModel
            .getIntroItems()
            .retry(5)
            .asObservable()
            .map { ($0.0, $0.1, $0.2, $0.3) }
        } else {
            let sura: [SuraCodable] = db.objects(SuraCodable.self)
            let language: [Language] = db.objects(Language.self)
            let translation: [Translation] = db.objects(Translation.self)
            let wordTranslation: [WordTranslation] = db.objects(WordTranslation.self)
            return Observable<([Language], [Translation], [WordTranslation], [SuraCodable])>.just((language, translation, wordTranslation, sura))
        }
    }
    
    func getSuras() -> Observable<[SuraCodable]> {
        if db.objects(Sura.self).isEmpty {
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
            let sura: [SuraCodable] = db.objects(SuraCodable.self)
            return Observable<[SuraCodable]>.just(sura)
        }
        
        
    }
    
}
