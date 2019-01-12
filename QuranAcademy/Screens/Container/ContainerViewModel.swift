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

struct ContainerViewModel {
    
    let provider = MoyaProvider<QuranEndpoint>()
    
    func getLanguages() -> Single<Languages> {
        return provider.rx
            .request(.getLanguages)
            .filterSuccessfulStatusCodes()
            .debug()
            .retry(3)
            .map { try JSONDecoder().decode(Languages.self, from: $0.data) }
    }
    
}
