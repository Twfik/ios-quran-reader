//
//  SettingsViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 22/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import RxSwift

final class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var translationsLabel: UILabel!
    @IBOutlet weak var tafsirLabel: UILabel!
    @IBOutlet weak var wordTranslationLabe: UILabel!
    @IBOutlet weak var showTranslationLabel: UILabel!
    @IBOutlet weak var readOnlyTasfirLabel: UILabel!
    @IBOutlet weak var interfaceLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var surasLanguageLabel: UILabel!
    @IBOutlet weak var translationAuthorLabel: UILabel!
    @IBOutlet weak var wordTranslationLabel: UILabel!
    @IBOutlet weak var arabicSwitch: UISwitch!
    @IBOutlet weak var translationSwitch: UISwitch!
    @IBOutlet weak var tafsirSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setTheme() {
        Theme.themeWasChanged
            .startWith(())
            .withUnretained(self)
            .subscribe(onNext: { (vc, _) in
                vc.navigationController?.navigationBar.barTintColor = Theme.current.navigationBarColor
                
                vc.tableView.backgroundColor = Theme.current.tableViewBackgroundColor
                vc.tableView.separatorColor = Theme.current.tableViewSeparatorColor
                vc.setupLabels()
                vc.tableView.reloadData()
            }).disposed(by: bag)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = Theme.current.backgroundColor
        cell.textLabel?.textColor = Theme.current.textColor
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        // Секция Основные
        case 0:
            switch indexPath.row {
            case 0:
                let languagesVC = UIStoryboard.get(LanguagesViewController.self)
                let viewModel = LanguagesViewModel()
                languagesVC.viewModel = viewModel
                languagesVC.isSettingsVC = true
                push(languagesVC, animated: true)
            case 1:
                let translationsVC = UIStoryboard.get(TranslationsViewController.self)
                translationsVC.isSettingsVC = true
                push(translationsVC, animated: true)
            case 2:
                let wordTranslationsVC = UIStoryboard.get(WordTranslationsViewController.self)
                wordTranslationsVC.isSettingsVC = true
                push(wordTranslationsVC, animated: true)
            default:break
            }
            
        // Секция Настройка Отображения
        case 1:
            switch indexPath.row {
            case 2:
                print("3")
                let fontVC = UIStoryboard.get(FontViewController.self)
                let presenter = FontViewPresenter(view: fontVC)
                fontVC.presenter = presenter
                push(fontVC, animated: true)
            case 4:
                print("4")
            default: print("")
            }
            print("Секция 2")
            
        case 2:
            
            switch indexPath.row {
            case 0: print("")
            default: break
            }
            
        // Дефолтная секция
        default:  break
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = Theme.current.textColor
    }
    
}

extension SettingsViewController {
    
    private func setup() {
        setTheme()
        setupLabels()
        setupSwitches()
        disableSwitchIfNeeded()
    }
    
    private func setupLabels() {
        languageLabel.text = "\(Preferences.language)"
        translationAuthorLabel.text = Preferences.translation
        wordTranslationLabel.text = Preferences.wordTranslation
        
        languageLabel.textColor = Theme.current.textColor
        translationsLabel.textColor = Theme.current.textColor
        tafsirLabel.textColor = Theme.current.textColor
        wordTranslationLabe.textColor = Theme.current.textColor
        showTranslationLabel.textColor = Theme.current.textColor
        readOnlyTasfirLabel.textColor = Theme.current.textColor
        interfaceLabel.textColor = Theme.current.textColor
        aboutLabel.textColor = Theme.current.textColor
    }
    
    private func setupSwitches() {
//        arabicSwitch.isOn = Preferences.showArabic
//        translationSwitch.isOn = Preferences.showTranslation
    }
    
    private func disableSwitchIfNeeded() {
//        translationSwitch.isEnabled = arabicSwitch.isOn
//        arabicSwitch.isEnabled = translationSwitch.isOn
    }
}

// MARK: - Actions
extension SettingsViewController {
    
    @IBAction func showArabic(_ sender: UISwitch) {
        disableSwitchIfNeeded()
        Preferences.showArabic = sender.isOn
    }
    
    @IBAction func showTranslations(_ sender: UISwitch) {
        disableSwitchIfNeeded()
        Preferences.showTranslation = sender.isOn
    }
    
    @IBAction func onlyTafsir(_ sender: UISwitch) {
        
    }
    
}
