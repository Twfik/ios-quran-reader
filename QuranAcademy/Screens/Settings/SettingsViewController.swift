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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languageLabel.text = "\(Preferences.language)"
        
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.262745098, green: 0.3176470588, blue: 0.2196078431, alpha: 1)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        default:
            break
        }

    }

    
    
    
}
