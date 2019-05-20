//
//  SuraDetailViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 13/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class SuraViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SuraViewModel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        view.backgroundColor = Theme.current.backgroundColor
    }
    
}

extension SuraViewController {
    
    private func setup() {
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = Theme.current.tableViewBackgroundColor
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
    }
    
}

extension SuraViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        let maxWidth: CGFloat = tableView.bounds.width - 32
//        let indents: CGFloat = 5 * 2
        
        switch cellTypes(for: indexPath.section)[indexPath.row] {
        case .arabic:
            let ayat = viewModel.ayats[indexPath.section].text
            let arabicFont = ArabicFont.current.font
            let arAttributes = [NSAttributedString.Key.font: arabicFont]
            
            let ayahTextHeight = ayat.height(with: arAttributes, maxWidth: maxWidth).rounded(.up)
            return ceil(ayahTextHeight + 27) //FIXME:
        case .translation:
            let leftContainerIndent: CGFloat = 10
            let rightContainerIndent: CGFloat = 10
            
            let leftIndentToContainer: CGFloat = 10
            let rightLabelIndentToContainer: CGFloat = 10
            
            let topContainerIndent: CGFloat = 5
            let bottomContainerIndent: CGFloat = 0
            
            let topLabelIndentToContainer: CGFloat = 6
            let bottomLabelIndentToContainer: CGFloat = 6
            
            let maxWidth: CGFloat = tableView.bounds.width - leftContainerIndent - leftIndentToContainer - rightContainerIndent - rightLabelIndentToContainer
            let translation = viewModel.translations[indexPath.section].text
            let trAttributes = TranslationCell.translationTextAttributes
            let translationTextHeight = translation.height(with: trAttributes, maxWidth: maxWidth).rounded(.up)
            let totalHeight = translationTextHeight + topContainerIndent + topLabelIndentToContainer + bottomContainerIndent + bottomLabelIndentToContainer - 5
            return ceil(totalHeight)
        }
        
    }

}
