//
//  LanguagesViewModel.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Moya
import RxSwift
import RxSwiftExt

final class QAJSONDecoder: JSONDecoder {

    override init() {
        super.init()
        self.keyDecodingStrategy = .convertFromSnakeCase
    }
    
}

struct IntroViewModel {
    
    var languages: [Language]
    var provider: MoyaProvider<QuranEndpoint>
    var suras: [Sura]?
    
    init(languages: [Language], provider: MoyaProvider<QuranEndpoint>) {
        self.languages = languages
        self.provider = provider
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
    
    /// Возвращает список описаний смысловых переводов
    func getTranslations() -> Observable<Translations> {
        return provider.rx
            .request(.getSurasTranslations)
            .filterSuccessfulStatusCodes()
            .debug()
            .retry(5)
            .asObservable()
            .map {try JSONDecoder().decode(Translations.self, from: $0.data)}
            .asObservable()
    }
    
    /// Возвращает список описаний пословных переводов
    func getWordTranslations() -> Observable<WordTranslations> {
        return provider.rx
            .request(.getTranslationsAndTafsirs)
            .filterSuccessfulStatusCodes()
            .debug()
            .retry(5)
            .map { try JSONDecoder().decode(WordTranslations.self, from: $0.data) }
            .asObservable()
    }
    
    func getAll() -> Observable<(SurasResponse, Translations, WordTranslations)> {
       return Observable.zip(getSuras(), getTranslations(), getWordTranslations())
            .debug()
            .retry()
            .map { $0 }
    }
    
}
