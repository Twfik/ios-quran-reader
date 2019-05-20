//
//  ThemeCellModel.swift
//  QuranAcademy
//
//  Created by Ayub on 03/05/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation

struct ThemeCellModel: FontCellModelProtocol {
    var blueThemeButtonTapped: ((Int) -> Void)?
    var greenThemeButtonTapped: ((Int) -> Void)?
    var darkThemeButtonTapped: ((Int) -> Void)?
}
