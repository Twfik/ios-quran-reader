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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isSettingsVC ? .lightContent : .default
    }
    
}

//MARK: - Setup
extension WordTranslationsViewController {
    
    private func setup() {
        setupTableView()
        getTranslations()
        addRightNavBarButton()
    }
    
    private func setupTableView() {
        tableView.registerNib(SimpleCell.self)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        setupHeaderView()
    }
    
    private func setupHeaderView() {
        guard !isSettingsVC else {
            title = "Пословный перевод"
            return }
        let headerView = UIView.loadFromNib(SimpleHeader.self)
        headerView.configure(text: "Выберите пословный перевод")
        tableView.setTableHeaderView(header: headerView, height: 150)
    }
    
    private func getTranslations() {
        let db = SQLiteStorage()
        wordTranslations = db.objects(WordTranslation.self)
    }
    
    private func addRightNavBarButton() {
        guard !isSettingsVC else { return }
        let barButtonItem = UIBarButtonItem(title: "Далее",
                                            style: .plain,
                                            target: self,
                                            action: #selector(pushTabbarController))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func pushTabbarController() {
        let tabbar = UIStoryboard.get(MainTabBarController.self)
        UserDefaults.standard.set(true, forKey: Keys.isСonfigured)
        navigationController?.setViewControllers([tabbar], animated: true)
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
