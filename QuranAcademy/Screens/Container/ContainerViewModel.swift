//
//  ContainerViewModel.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation
import Moya
import RxSwift

final class ContainerViewModel {
    
    let provider = MoyaProvider<QuranEndpoint>()
    let database = SQLiteStorage(.list)
    
    /// Возвращает список доступных языков
    func getLanguages() -> Observable<LanguagesResponse> {
        return provider.rx
            .request(.getLanguages)
            .filterSuccessfulStatusCodes()
            .debug()
            .asObservable()
            .retry(3)
            .map { $0.data }
            .decode(LanguagesResponse.self)
    }
    
    /// Возвращает список описаний смысловых переводов
    func getTranslations() -> Observable<TranslationsResponse> {
        return provider.rx
            .request(.getTranslationsAndTafsirs)
            .filterSuccessfulStatusCodes()
            .debug()
            .asObservable()
            .retry(5)
            .map { $0.data }
            .decode(TranslationsResponse.self)
    }
    
    /// Возвращает список описаний пословных переводов
    func getWordTranslations() -> Observable<WordTranslationsResponse> {
        return provider.rx
            .request(.getWordByWordTranslations)
            .filterSuccessfulStatusCodes()
            .debug()
            .asObservable()
            .retry(5)
            .map { $0.data }
            .decode(WordTranslationsResponse.self)
    }
    
    /// Возвращает список описаний сур Корана
    func getSuras() -> Observable<SurasResponse> {
        return provider.rx
            .request(.getSuras)
            .filterSuccessfulStatusCodes()
            .debug()
            .retry(3)
            .asObservable()
            .map { $0.data }
            .decode(SurasResponse.self)
    }
    
    func getIntroItems() -> Observable<([Language], [Translation], [WordTranslation], [SuraCodable])> {
        return Observable.zip(getLanguages(), getTranslations(), getWordTranslations(), getSuras())
            .debug()
            .retry(5)
            .map { ($0.0.languages, $0.1.translations, $0.2.wordTranslations, $0.3.suras) }
    }
    
    func save(_ languages: [Language],_ translations: [Translation], _ wordTranslations: [WordTranslation],_ suras: [SuraCodable]) {
        let db = SQLiteStorage(.list)
        db.createListTables()
        
        db.save(languages, table: Tables.language)
        db.save(translations, table: Tables.translation)
        db.save(wordTranslations, table: Tables.wordTranslation)
        db.save(suras, table: Tables.sura)
    }
}
