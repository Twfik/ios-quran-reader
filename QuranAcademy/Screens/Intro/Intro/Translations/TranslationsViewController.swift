//
//  TranslationsViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 22/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class TranslationsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var translations = [Translation]()
    var isSettingsVC = false
    let db = SQLiteStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translations = db.objects(Translation.self)
        tableView.registerNib(TranslationTableViewCell.self)
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableView.automaticDimension
        setupHeaderView()
        addRightNavBarButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isSettingsVC ? .lightContent : .default
    }
    
    private func setupHeaderView() {
        guard !isSettingsVC else {
            title = "Смысловой перевод"
            return }
        let headerView = UIView.loadFromNib(SimpleHeader.self)
        headerView.configure(text: "Выберите смысловой перевод")
        tableView.setTableHeaderView(header: headerView, height: 150)
    }
    
    private func addRightNavBarButton() {
        guard !isSettingsVC else { return }
        let barButtonItem = UIBarButtonItem(title: "Далее",
                                            style: .plain,
                                            target: self,
                                            action: #selector(pushWordTranslationVC))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func pushWordTranslationVC() {
        let translationVC = UIStoryboard.get(WordTranslationsViewController.self)
        push(translationVC, animated: true)
    }
    
    private func getLanguageBy(code: String) -> String {
        let languages: [Language] = db.objects(Language.self)
        for language in languages {
            if language.code == code {
                return language.name
            }
        }
        return ""
    }
    
    private func downloadTranslationWithProgress(message: String, url: String, fileName: String, result: @escaping (Success?, Error?, Cancelled?) -> Void) {
        let loadingProgressVC = UIStoryboard.get(DownloadViewController.self)
        loadingProgressVC.modalPresentationStyle = .overCurrentContext
        loadingProgressVC.modalTransitionStyle = .crossDissolve
        loadingProgressVC.message = message
        let viewModel = DownloadViewModel()
        viewModel.url = url
        viewModel.fileName = fileName
        viewModel.action = { succeses, error, cancelled in
            result(succeses, error, cancelled)
        }
        loadingProgressVC.viewModel = viewModel
        present(loadingProgressVC, animated: true)
    }
    
}

// MARK: - TableView DataSource
extension TranslationsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return translations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TranslationTableViewCell.self, indexPath: indexPath)
        
        let translation = translations[indexPath.row]
        let language = getLanguageBy(code: translation.languageCode)
        cell.configure(translation: translation, language: language)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TranslationTableViewCell else { return }
        
        let translation = translations[indexPath.row]
        
        let documentsURL = FileManager.default.documentsURL
        let file = documentsURL.appendingPathComponent("\(translation.code).db")
        
        if FileManager.default.fileExists(atPath: file.path) {
            Preferences.translationCode = translation.code
            setCheckmark(cell: cell, translation: translation.code)
        } else {
            downloadTranslationWithProgress(message: translation.name,
                             url: translation.fileUrl,
                             fileName: "\(translation.code).db",
                result: { [weak self] success, error, cancelled in
                    guard error == nil && cancelled == nil else { return }
                    self?.setCheckmark(cell: cell, translation: translation.code)
                    Preferences.translationCode = translation.code
            })
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func setCheckmark(cell: UITableViewCell, translation: String) {
        cell.accessoryView = nil
        
        for i in tableView.visibleCells {
            if i.textLabel?.text != translation {
                i.accessoryType = .none
            }
        }
        
        cell.accessoryType = .checkmark
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
