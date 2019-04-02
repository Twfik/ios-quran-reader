//
//  FontViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 04/03/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

class FontViewController: UIViewController {
    
    let arabicFonts = ["me_quran", "me_quran2", "KFGQPC Uthmanic Script HAFS"]
    let translationFonts = ["Proxima Nova", "Georgia", "Palatino"]
    
    var fonts: [String] {
        return segmentedControl.selectedSegmentIndex == 0 ? arabicFonts : translationFonts
    }
    var currentFont: String {
       return segmentedControl.selectedSegmentIndex == 0 ? Preferences.arabicFont : Preferences.translationFont
    }
    
    var currentFontSize: Int {
        return segmentedControl.selectedSegmentIndex == 0 ? Preferences.arabicFontSize : Preferences.translationFontSize
    }
    
    var exampleText: String {
        return segmentedControl.selectedSegmentIndex == 0 ? "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ" : "Хвала Аллаху, Господу миров"
    }

    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var exampleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        title = "Шрифты"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hidesBottomBarWhenPushed = true
    }

}

//MARK: - Setup
extension FontViewController {
    
    private func setup() {
        updateExampleLabel()
        setupTableView()
    }
    
    private func updateExampleLabel() {
        exampleLabel.font = UIFont(name: currentFont, size: CGFloat(currentFontSize))
        exampleLabel.text = exampleText
        fontSizeSlider.value = Float(currentFontSize)
    }
    
    private func setupTableView() {
        tableView.registerNib(FontCell.self)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }
    
}

//MARK: - Actions
extension FontViewController {
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
        updateExampleLabel()
    }
    
    @IBAction func fontSizeSliderChanged(_ sender: UISlider) {
        let size = sender.value
        if segmentedControl.selectedSegmentIndex == 0 {
            Preferences.arabicFontSize = Int(size)
        } else {
            Preferences.translationFontSize = Int(size)
        }
        exampleLabel.font = UIFont(name: currentFont, size: CGFloat(currentFontSize))

    }

    
}

extension FontViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fonts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(FontCell.self, indexPath: indexPath)
        cell.configure(font: fonts[indexPath.row], currentFont: currentFont)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FontCell else { return }
        let font = cell.fontLabel.text ?? ""
        
        for i in tableView.visibleCells {
            if i.textLabel?.text != "\(currentFont)" {
                i.accessoryType = .none
            }
        }
        
        if segmentedControl.selectedSegmentIndex == 0 {
            Preferences.arabicFont = font
        } else {
            Preferences.translationFont = font
        }
        exampleLabel.font = UIFont(name: currentFont, size: CGFloat(currentFontSize))
        tableView.deselectRow(at: indexPath, animated: true)
        cell.accessoryType = .checkmark
    }

    
    
}
