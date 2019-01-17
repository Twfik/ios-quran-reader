//
//  Observable+Decodable.swift
//  QuranAcademy
//
//  Created by Ayub on 14/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType where E == Data {
    
    func decode<T>(_ type: T.Type, decoder: JSONDecoder = QAJSONDecoder()) -> Observable<T> where T: Decodable {
        return map { data -> T in
            return try decoder.decode(T.self, from: data)
        }
    }
    
}
