//
//  TextHeight.swift
//  QuranAcademy
//
//  Created by Ayub on 05/02/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import Foundation

typealias TextAttributes = [NSAttributedString.Key: Any]

extension String {
    
    func rect(with attributes: TextAttributes, maxWidth: CGFloat = .infinity, maxHeight: CGFloat = .infinity) -> CGRect {
        let maxSize = CGSize(width: maxWidth, height: maxHeight)
        return (self as NSString)
            .boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
    }
    
    func calculateTextRect(font: String, size: CGFloat) -> CGFloat {
        guard let textFont: UIFont = UIFont(name: font, size: size) else { return 0 }
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byWordWrapping
        
        let attributes = [NSAttributedString.Key.font: textFont,
                          NSAttributedString.Key.paragraphStyle: style]
        return self.rect(with: attributes).height.rounded(.up)
    }
}
