//
//  Sura.swift
//  QuranAcademy
//
//  Created by Ayub on 13/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class ChapterCell: UITableViewCell {
    
    @IBOutlet weak var suraArLabel: UILabel!
    @IBOutlet weak var suraTranslationLabel: UILabel!
    @IBOutlet weak var suraNumberLabel: UILabel!
    @IBOutlet weak var suraTransliterationLabel: UIImageView!
    @IBOutlet weak var containerView: NeverClearView!
    @IBOutlet weak var suraNumberContainerView: NeverClearView!
    @IBOutlet weak var ayahCountLabel: UILabel!
    
    func configure(sura: Sura) {
        suraArLabel.text = "\(sura.name.arabic)"
        suraTranslationLabel.text = "\(sura.name.translation)"
        suraNumberLabel.text = "\(sura.id)"
        ayahCountLabel.text = "\(sura.ayatCount)"
    }
    
    override func didMoveToSuperview() {
        let selectedView = UIView(frame: bounds)
        selectedView.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.4, blue: 0.6039215686, alpha: 0.099390625)
        selectedBackgroundView = selectedView
        
        super.didMoveToSuperview()
    }
    
    override func awakeFromNib() {
        containerView.layer.cornerRadius = containerView.bounds.width / 2
        suraNumberContainerView.layer.cornerRadius = suraNumberContainerView.bounds.width / 2
    }
    
}

class NeverClearView: UIView {
    override var backgroundColor: UIColor? {
        didSet {
            if backgroundColor != nil && backgroundColor!.cgColor.alpha == 0 {
                backgroundColor = oldValue
            }
        }
    }
}
