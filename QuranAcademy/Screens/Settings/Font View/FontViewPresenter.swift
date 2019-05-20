//
//  FontViewPresenter.swift
//  QuranAcademy
//
//  Created by Ayub on 03/05/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import RxSwift

final class FontViewPresenter {
    
    var view: FontViewController!
    private var cellModels: [[FontCellModelProtocol]] = []
    private var selectedSegmentIndex = 0
    private let bag = DisposeBag()
    
    init(view: FontViewController) {
        self.view = view
    }
    
    func viewDidLoad() {
        setupFontTableViewModels()
    }
    
    func setupFontTableViewModels() {
        cellModels = []
        // Slider Cell
        var sliderCellModel = FontSizeCellModel()
        sliderCellModel.sliderValueChanged = { [weak self] value in
            self?.sliderValueChanged(value)
        }
        cellModels.append([sliderCellModel])
        
        // Example Font Cell
        let exampleCellModel = ExampleTextCellModel()
        cellModels.append([exampleCellModel])
        
        // Arabic or Translation Cell
        var segmentedControlCellModel = SegmentedControlCellModel()
        segmentedControlCellModel.segmentedControlValueChanged = { [weak self] value in
            self?.segmentedControlIndexChanged(value)
        }
        cellModels.append([segmentedControlCellModel])
        
        // Choose Font Cell
        let arabicFonts = ArabicFont.allCases
        let translationFonts = TranslationFont.allCases
        var fontCellModels: [FontCellModel] = []
        if selectedSegmentIndex == 0 {
            for font in arabicFonts {
                var fontCellModel = FontCellModel(fontName: font.title, currentFont: ArabicFont.current.title)
                fontCellModel.arabicFont = font
                fontCellModels.append(fontCellModel)
            }
            cellModels.append(fontCellModels)
        }
        
        if selectedSegmentIndex == 1 {
            for font in translationFonts {
                var fontCellModel = FontCellModel(fontName: font.title, currentFont: TranslationFont.current.title)
                fontCellModel.translationFont = font
                fontCellModels.append(fontCellModel)
            }
            cellModels.append(fontCellModels)
        }
        
        // Theme Cell
        var themeCellModel = ThemeCellModel()
        themeCellModel.blueThemeButtonTapped = { [weak self] value in
            self?.blueThemeButtonTapped(value)
        }
        
        themeCellModel.darkThemeButtonTapped = { [weak self] value in
            self?.darkThemeButtonTapped(value)
        }
        
        themeCellModel.greenThemeButtonTapped = { [weak self] value in
            self?.greenThemeButtonTapped(value)
        }
        
        cellModels.append([themeCellModel])
        view.updateCellModels(cellModels)
    }
    
}

// MARK: - Cell Actions
extension FontViewPresenter {
    
    func sliderValueChanged(_ value: Float) {
        view.updateSliderValue(value)
    }
    
    func segmentedControlIndexChanged(_ index: Int) {
        selectedSegmentIndex = index
        view.updateSegmentedControlIndex(index)
        setupFontTableViewModels()
    }
    
    func blueThemeButtonTapped(_ value: Int) {
        Theme.init(rawValue: value)?.apply()
        view.tableView.reloadData()
    }
    
    func greenThemeButtonTapped(_ value: Int) {
        Theme.init(rawValue: value)?.apply()
    }
    
    func darkThemeButtonTapped(_ value: Int) {
        Theme.init(rawValue: value)?.apply()
    }
    
}
