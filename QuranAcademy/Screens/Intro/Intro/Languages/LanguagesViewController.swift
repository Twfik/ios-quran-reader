//
//  ViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import SQLite

class LanguagesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var indexNumber = -1
    private var db = SQLiteStorage(.list)
    var viewModel: LanguagesViewModel!
    var isSettingsVC = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        guard !isSettingsVC else { return }
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        title = "Язык"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
}

//MARK: - Setup
extension LanguagesViewController {
    
    private func setup() {
        setupTableView()

        if !isSettingsVC {
            addRightNavBarButton()
        }
    }
    
    private func addRightNavBarButton() {
        let barButtonItem = UIBarButtonItem(title: "Далее",
                                            style: .plain,
                                            target: self,
                                            action: #selector(pushTranslationVC))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func pushTranslationVC() {
        let translationVC = UIStoryboard.get(TranslationsViewController.self)
        push(translationVC, animated: true)
    }
    
    private func setupTableView() {
        tableView.registerNib(SimpleCell.self)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        if !isSettingsVC {
            tableView.setHeaderView(text: "Выберите перевод")
        } else {
            title = "Выберите язык"
        }
    }
    
    private func fetchSuras(_ code: String, completion: @escaping (() -> Void)) {
        viewModel.getSuras()
            .subscribe(onNext: { [unowned self] (suras) in
                self.db.save(suras, table: Tables.sura)
                completion()
            }, onError: { (error) in
                print(error.localizedDescription)
            }).disposed(by: bag)
    }
    
    private func fetchItems(completion: @escaping (() -> Void)) {
        viewModel.getAll()
            .subscribe(onNext: { [unowned self] (lang, transl, wordTransl, sura) in
                self.viewModel.containerViewModel.save(lang, transl, wordTransl, sura)
                completion()
            }, onError: { (error) in
                print(error.localizedDescription)
            }).disposed(by: bag)
    }
    
    private func showSpinner(for cell: SimpleCell) {
        let spinner = UIActivityIndicatorView()
        spinner.style = .gray
        cell.accessoryView = spinner
        spinner.startAnimating()
    }
    
}

extension LanguagesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(SimpleCell.self, indexPath: indexPath)
        let language = viewModel.languages[indexPath.row]
        cell.configure(language)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SimpleCell else { return }
        
        let language = viewModel.languages[indexPath.row]
        let code = language.code
        
        showSpinner(for: cell)
        Preferences.code = code
        db.createTable(Tables.sura, .sura)
        
        fetchItems {
            cell.accessoryView = nil
            Preferences.language = language.name
            NotificationCenter.default.post(name: .kUpdateSuras, object: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        for i in tableView.visibleCells {
            if i.textLabel?.text != "\(language.name)" {
                i.accessoryType = .none
            }
        }
        
        cell.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
}

