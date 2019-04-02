//
//  SuraDetailViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 13/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import SQLite

final class SuraDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SuraDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
}

extension SuraDetailViewController {
    
    private func setup() {
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.registerNib(AyahCell.self)
        tableView.registerNib(TranslationCell.self)
        setupTableViewHeader()

        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }
    
    private func setupTableViewHeader() {
        guard viewModel.showBasmala else { return }
        let basmalaHeaderView = UIView.loadFromNib(BasmalaHeader.self)
        basmalaHeaderView.configure(Basmala())
        tableView.setTableHeaderView(header: basmalaHeaderView)
    }

    
    private func setupNavigationBar() {
        title = "\(viewModel.sura.translation)"
        navigationItem.setHidesBackButton(false, animated: true)
    }
    
}

extension SuraDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func cellTypes(for section: Int) -> [QuranCellType] {
        var showTypes: [QuranCellType] = []
        
        if !Preferences.showArabic {
            showTypes = [.translation]
        } else if !Preferences.showTranslation || viewModel.translations.isEmpty {
            showTypes = [.arabic]
        } else {
            showTypes = [.arabic, .translation]
        }

        return showTypes
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes(for: section).count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.ayats.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let evenCells = indexPath.row % 2 == 0
        cell.contentView.backgroundColor = evenCells ? #colorLiteral(red: 0.9607843137, green: 0.9411764706, blue: 0.8666666667, alpha: 0.5) : #colorLiteral(red: 0.9725490196, green: 0.9490196078, blue: 0.862745098, alpha: 0.5)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellTypes(for: indexPath.section)[indexPath.row] {
        case .arabic:
            let ayah = viewModel.ayats[indexPath.section]
            let cell = tableView.dequeue(AyahCell.self, indexPath: indexPath)
            cell.configure(ayah)
            return cell
        case .translation:
            let translation = viewModel.translations[indexPath.section]
            let cell = tableView.dequeue(TranslationCell.self, indexPath: indexPath)
            cell.configure(translation)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let maxWidth: CGFloat = tableView.bounds.width - 65
        let indents: CGFloat = 5 * 2
        
        switch cellTypes(for: indexPath.section)[indexPath.row] {
        case .arabic:
            let ayat = viewModel.ayats[indexPath.section].text
            let arabicFont = UIFont(name: Preferences.arabicFont, size: CGFloat(Preferences.arabicFontSize)) ?? UIFont.systemFont(ofSize: 20)
            let arAttributes = [NSAttributedString.Key.font: arabicFont]
            
            let ayahTextHeight = ayat.height(with: arAttributes, maxWidth: maxWidth).rounded(.up)
            return ayahTextHeight + indents
        case .translation:
            let translation = viewModel.translations[indexPath.section].text
            let trAttributes = TranslationCell.translationTextAttributes
            let translationTextHeight = translation.height(with: trAttributes, maxWidth: maxWidth).rounded(.up)
            return translationTextHeight + indents // FIXME:
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 0.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.8078431373, blue: 0.7294117647, alpha: 1)
        return view
    }
    
}
