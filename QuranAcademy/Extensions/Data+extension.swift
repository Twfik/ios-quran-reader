//
//  Data+extension.swift
//  taxi05
//
//  Created by Abdul Tawfik on 31/08/2018.
//  Copyright © 2018 Abdullah Tawfik. All rights reserved.
//

import Foundation

extension Data {
    func toString() -> String {
        return String(data: self, encoding: .windowsCP1251) ?? ""
    }
}
