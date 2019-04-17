//
//  SettingsViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 22/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var translationAuthorLabel: UILabel!
    @IBOutlet weak var wordTranslationLabel: UILabel!
    @IBOutlet weak var arabicSwitch: UISwitch!
    @IBOutlet weak var translationSwitch: UISwitch!
    @IBOutlet weak var tafsirSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
                let fontVC = FontViewController()
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
    
}

extension SettingsViewController {
    
    private func setup() {
        setupLabels()
        setupSwitches()
        disableSwitchIfNeeded()
        
    }
    
    private func setupLabels() {
        languageLabel.text = "\(Preferences.language)"
        translationAuthorLabel.text = Preferences.translation
        wordTranslationLabel.text = Preferences.wordTranslation
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
