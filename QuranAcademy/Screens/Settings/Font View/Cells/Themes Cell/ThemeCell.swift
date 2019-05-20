//
//  ThemeCell.swift
//  QuranAcademy
//
//  Created by Ayub on 03/05/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {

    var cellModel: ThemeCellModel!
    
    @IBOutlet weak var blueThemeButton: UIButton!
    @IBOutlet weak var greenThemeButton: UIButton!
    @IBOutlet weak var darkThemeButton: UIButton!
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func blueThemeButtonTapped(_ sender: UIButton) {
        cellModel.blueThemeButtonTapped?(0)
        highlightThemeButton(sender)
    }

    @IBAction func greenThemeButtonTapped(_ sender: UIButton) {
        cellModel.greenThemeButtonTapped?(1)
        highlightThemeButton(sender)
    }
    @IBAction func darkThemeButtonTapped(_ sender: UIButton) {
        cellModel.darkThemeButtonTapped?(2)
        highlightThemeButton(sender)
    }
    
    func configure(withModel model: ThemeCellModel) {
        self.cellModel = model
        
        backgroundColor = Theme.current.backgroundColor
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    
        let tag = Theme.themeRawValue + 1
        
        buttons.forEach {
            $0.layer.cornerRadius = $0.bounds.width / 2
            if tag == $0.tag {
                highlightThemeButton($0)
            }
        }
        
    }
    
    private func highlightThemeButton(_ button: UIButton) {
        buttons.forEach { $0.layer.borderColor = UIColor.clear.cgColor }
        button.layer.borderColor = Theme.current.highlight.cgColor
        button.layer.borderWidth = 2
    }
    
}
