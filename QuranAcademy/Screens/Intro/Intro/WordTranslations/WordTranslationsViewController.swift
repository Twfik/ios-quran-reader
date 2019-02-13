//
//  WordTranslationsViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 22/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class WordTranslationsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var isSettingsVC = false
    private var wordTranslations = [WordTranslation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: - Setup
extension WordTranslationsViewController {
    
    private func setup() {
        setupTableView()
        getTranslations()
    }
    
    private func setupTableView() {
        tableView.registerNib(SimpleCell.self)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        if !isSettingsVC {
            tableView.setHeaderView(text: "Выберите пословный перевод")
            addRightNavBarButton()
        } else {
            title = "Пословный перевод"
        }
    }
    
    private func getTranslations() {
        let db = SQLiteStorage(.list)
        wordTranslations = db.objects(WordTranslation.self, table: Tables.wordTranslation)
    }
    
    private func addRightNavBarButton() {
        let barButtonItem = UIBarButtonItem(title: "Далее",
                                            style: .plain,
                                            target: self,
                                            action: #selector(pushTabbarController))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func pushTabbarController() {
        let tabbar = UIStoryboard.get(MainTabBarController.self)
        UserDefaults.standard.set(true, forKey: Keys.isСonfigured)
        navigationController?.setNavigationBarHidden(true, animated: false)
        push(tabbar, animated: true)
    }
    
}

//MARK: - TableView Protocols
extension WordTranslationsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordTranslations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(SimpleCell.self, indexPath: indexPath)
        let translation = wordTranslations[indexPath.row]
    
        cell.titleLabel.text = translation.languageName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
}
