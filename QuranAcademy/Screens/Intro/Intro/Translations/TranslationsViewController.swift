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
    
    private func showProgressView(message: String, url: String, fileName: String) {
        let loadingProgressVC = UIStoryboard.get(DownloadViewController.self)
        loadingProgressVC.modalPresentationStyle = .overCurrentContext
        loadingProgressVC.modalTransitionStyle = .crossDissolve
        loadingProgressVC.message = message
        let viewModel = DownloadViewModel()
        viewModel.url = url
        viewModel.fileName = fileName
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
        
        Preferences.translationCode = translation.code
        let documentsURL = FileManager.default.documentsURL
        let file = documentsURL.appendingPathComponent("\(Preferences.translationCode).db")

        
        if !FileManager.default.fileExists(atPath: file.path) {
            print(!FileManager.default.fileExists(atPath: file.path))
            print(Preferences.translationCode)
            showProgressView(message: translation.name, url: translation.fileUrl, fileName: "\(translation.code).db")
        } else {
            print(Preferences.translationCode)
            Preferences.translationCode = translation.code
        }
        
        for i in tableView.visibleCells {
            if i.textLabel?.text != "\(translation.code)" {
                i.accessoryType = .none
            }
        }
        
        cell.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
    
}
