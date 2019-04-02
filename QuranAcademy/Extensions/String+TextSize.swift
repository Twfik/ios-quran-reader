//
//  String+TextSize.swift
//  QuranAcademy
//
//  Created by Ayub on 04/03/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func height(with attributes: [NSAttributedString.Key: Any], maxWidth: CGFloat) -> CGFloat {
        let maxSize = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        return self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).height
    }
    
}
