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
    private var db = SQLiteStorage()
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
        addRightNavBarButton()
        setupTableView()
    }
    
    private func addRightNavBarButton() {
        guard !isSettingsVC else { return }
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
        setupHeaderView()
    }
    
    private func setupHeaderView() {
        guard !isSettingsVC else {
            title = "Выберите язык"
            return }
        let headerView = UIView.loadFromNib(SimpleHeader.self)
        headerView.configure(text: "Выберите перевод")
        tableView.setTableHeaderView(header: headerView, height: 100)
    }
    
    private func fetchItems(completion: @escaping ((Error?) -> Void)) {
        viewModel.getAll()
            .subscribe(onNext: { [unowned self] (lang, transl, wordTransl, sura) in
                if self.db.objects(Sura.self).isEmpty {
                    self.viewModel.containerViewModel.save(lang, transl, wordTransl, sura)
                }
                completion(nil)
                }, onError: { (error) in
                    completion(error)
                    print(error.localizedDescription)
            }).disposed(by: bag)
    }
    
    private func showSpinner(for cell: SimpleCell) {
        let spinner = UIActivityIndicatorView()
        let spinnerView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        spinner.style = .gray
        spinner.center = spinnerView.center
        spinnerView.addSubview(spinner)
        cell.accessoryView = spinnerView
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
        let prevCode = Preferences.code
        
        showSpinner(for: cell)
        Preferences.code = code
        db.createTable(Sura.self)
        
        self.fetchItems { [unowned self] error in
            if error != nil {
                self.showAlert(title: "Не удалось загрузить язык", message: "Попробуйте снова")
                Preferences.code = prevCode
            } else {
                Preferences.language = language.name
                NotificationCenter.default.post(name: .kUpdateSuras, object: nil)
                    self.setCheckmark(cell: cell, language: language.name)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    private func setCheckmark(cell: UITableViewCell, language: String) {
        cell.accessoryView = nil
        
        for i in tableView.visibleCells {
            if i.textLabel?.text != language {
                i.accessoryType = .none
            }
        }
        
        cell.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
}

