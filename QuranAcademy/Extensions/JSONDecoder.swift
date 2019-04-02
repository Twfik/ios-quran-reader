//
//  JSONDecoder.swift
//  QuranAcademy
//
//  Created by Ayub on 21/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//
import Foundation

final class QAJSONDecoder: JSONDecoder {
    
    override init() {
        super.init()
        self.keyDecodingStrategy = .convertFromSnakeCase
    }
    
}
