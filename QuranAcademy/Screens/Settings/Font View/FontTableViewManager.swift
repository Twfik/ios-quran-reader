//
//  FontTableViewManager.swift
//  QuranAcademy
//
//  Created by Ayub on 03/05/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

protocol FontCellModelProtocol { }

final class FontTableViewManager: NSObject {
    
    var tableView: UITableView!
    var presenter: FontViewPresenter!
    var cellModels: [[FontCellModelProtocol]] = []
    private var exampleCellIndexPath: IndexPath?
    private var fontCellIndexPath: IndexPath?
    private var selectedSegmentIndex = 0
    private let sections = ["РАЗМЕР ТЕКСТА",
                    "ПРЕДПРОСМОТР",
                    "",
                    "ШРИФТ",
                    "ЦВЕТОВАЯ ТЕМА"]
    
    init(tableView: UITableView, presenter: FontViewPresenter) {
        self.tableView = tableView
        self.presenter = presenter
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func updateCellModels(_ models: [[FontCellModelProtocol]]) {
        cellModels = models
        tableView.reloadData()
    }
    
    func updateSegmentedControlIndex(_ index: Int) {
        selectedSegmentIndex = index
    }
    
    func updateSliderValue(_ value: Float) {
        guard let indexPath = exampleCellIndexPath,
        let cell = tableView.cellForRow(at: indexPath) as? ExampleTextCell else { return }
        
        tableView.reloadDataWithContentSet()
    }
    
    
    
    func updateFonts(_ fonts: [String]) {
        
    }
    
}

extension FontTableViewManager: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = Theme.current.textColor
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = cellModels[indexPath.section][indexPath.row]
        
        switch model {
        case let model as SegmentedControlCellModel:
            let cell = tableView.dequeue(SegmentedControlCell.self, indexPath: indexPath)
            cell.configure(withModel: model)
            return cell
        case let model as FontSizeCellModel:
            let cell = tableView.dequeue(FontSizeCell.self, indexPath: indexPath)
            cell.configure(withModel: model)
            return cell
        case let model as ExampleTextCellModel:
            let cell = tableView.dequeue(ExampleTextCell.self, indexPath: indexPath)
            exampleCellIndexPath = indexPath
            cell.configure(withModel: model)
            return cell
        case let model as FontCellModel:
            let cell = tableView.dequeue(FontCell.self, indexPath: indexPath)
            cell.configure(withModel: model)
            return cell
        default:
            let model = model as? ThemeCellModel ?? ThemeCellModel()
            let cell = tableView.dequeue(ThemeCell.self, indexPath: indexPath)
            cell.configure(withModel: model)
            return cell
        }
    }
    
}

extension FontTableViewManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = cellModels[indexPath.section][indexPath.row] as? FontCellModel,
        let cell = tableView.cellForRow(at: indexPath) as? FontCell else { return }
        selectedSegmentIndex == 0 ? model.arabicFont?.apply() : model.translationFont?.apply()
        
        for i in tableView.visibleCells {
            print(model.currentFont)
            if i.textLabel?.text != model.currentFont {
                i.accessoryType = .none
            }
        }
        cell.accessoryType = .checkmark

        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadDataWithContentSet()
    }
    
}
