//
//  SimpleHeader.swift
//  QuranAcademy
//
//  Created by Ayub on 11/03/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class SimpleHeader: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(text: String) {
        titleLabel.text = text
    }
    
}
