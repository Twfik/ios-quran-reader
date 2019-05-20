//
//  ExampleTextCell.swift
//  QuranAcademy
//
//  Created by Ayub on 03/05/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import RxSwift

class ExampleTextCell: UITableViewCell {
    
    var cellModel: ExampleTextCellModel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var arabicTextLabel: UILabel!
    @IBOutlet weak var translationTextLabel: UILabel!
    
    func configure(withModel model: ExampleTextCellModel) {
        cellModel = model
        
        arabicTextLabel.text = cellModel.arabicExampleText
        translationTextLabel.text = cellModel.translationExampleText
        
        arabicTextLabel.textColor = Theme.current.textColor
        translationTextLabel.textColor = Theme.current.textColor
        
        arabicTextLabel.font = ArabicFont.current.font
        translationTextLabel.font = TranslationFont.current.font
        backgroundColor = Theme.current.backgroundColor
    }
    
    func updateFont(with name: String) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    func observeTextFont() {
        let fontWasChanged = Observable.zip(ArabicFont.fontWasChanged.asObserver(),
                                            TranslationFont.fontWasChanged.asObserver())
        fontWasChanged
            .subscribe(onNext: { [weak self] (_, _) in
                guard let self = self else { return }
                self.arabicTextLabel.font = ArabicFont.current.font
                self.translationTextLabel.font = TranslationFont.current.font
            }).disposed(by: bag)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        observeTextFont()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
