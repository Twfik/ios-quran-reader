//
//  FontViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 04/03/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import RxSwiftExt

class FontViewController: UIViewController {
    
    let arabicFonts = ["me_quran2", "KFGQPC Uthmanic Script HAFS"]
    let translationFonts = ["Proxima Nova", "Georgia", "Palatino"]
    
    private var fontTableViewManager: FontTableViewManager!
    var presenter: FontViewPresenter!
    
//    var selectedSegmentIndex: Int {
//        return segmentedControl.selectedSegmentIndex
//    }
//
//    var fonts: [String] {
//        return selectedSegmentIndex == 0 ? arabicFonts : translationFonts
//    }
//    var currentFont: String {
//       return selectedSegmentIndex == 0 ? Preferences.arabicFont : Preferences.translationFont
//    }
//
//    var currentFontSize: Int {
//        return selectedSegmentIndex == 0 ? Preferences.arabicFontSize : Preferences.translationFontSize
//    }
//
//    var exampleText: String {
//        return segmentedControl.selectedSegmentIndex == 0 ? "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ" : "Хвала Аллаху, Господу миров"
//    }

    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var exampleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        title = "Оформление"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

//MARK: - Setup
extension FontViewController {
    
    private func setup() {
        setupFontTableViewManager()
        presenter.viewDidLoad()
        setupTableView()
        
        Theme.themeWasChanged
            .startWith(())
            .withUnretained(self)
            .subscribe(onNext: { (vc, _) in
                vc.navigationController?.navigationBar.barTintColor = Theme.current.navigationBarColor

                vc.tableView.backgroundColor = Theme.current.tableViewBackgroundColor
                vc.tableView.separatorColor = Theme.current.tableViewSeparatorColor
                vc.tableView.reloadData()
            }).disposed(by: bag)
    }
    
    func updateCellModels(_ models: [[FontCellModelProtocol]]) {
        fontTableViewManager.updateCellModels(models)
    }
    
    private func setupFontTableViewManager() {
        fontTableViewManager = FontTableViewManager(tableView: tableView,
                                                    presenter: presenter)
        tableView.dataSource = fontTableViewManager
        tableView.delegate = fontTableViewManager
    }
    
    private func updateExampleLabel() {
//        exampleLabel.font = UIFont(name: currentFont, size: CGFloat(currentFontSize))
//        exampleLabel.text = exampleText
//        fontSizeSlider.value = Float(currentFontSize)
    }
    
    func updateSegmentedControlIndex(_ index: Int) {
        fontTableViewManager.updateSegmentedControlIndex(index)
    }
    
    func updateSliderValue(_ value: Float) {
        fontTableViewManager.updateSliderValue(value)
    }
    
    private func setupTableView() {
        tableView.registerNib(FontCell.self)
        tableView.registerNib(FontSizeCell.self)
        tableView.registerNib(ThemeCell.self)
        tableView.registerNib(ExampleTextCell.self)
        tableView.registerNib(SegmentedControlCell.self)

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
//        let size = sender.value
//        if segmentedControl.selectedSegmentIndex == 0 {
//            Preferences.arabicFontSize = Int(size)
//        } else {
//            Preferences.translationFontSize = Int(size)
//        }
//        exampleLabel.font = UIFont(name: currentFont, size: CGFloat(currentFontSize))

    }

    
}

//extension FontViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fonts.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeue(FontCell.self, indexPath: indexPath)
//        cell.configure(font: fonts[indexPath.row], currentFont: currentFont)
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? FontCell else { return }
//        let font = cell.fontLabel.text ?? ""
//        
//        for i in tableView.visibleCells {
//            if i.textLabel?.text != "\(currentFont)" {
//                i.accessoryType = .none
//            }
//        }
//        
//        if segmentedControl.selectedSegmentIndex == 0 {
//            Preferences.arabicFont = font
//        } else {
//            Preferences.translationFont = font
//        }
//        exampleLabel.font = UIFont(name: currentFont, size: CGFloat(currentFontSize))
//        tableView.deselectRow(at: indexPath, animated: true)
//        cell.accessoryType = .checkmark
//    }
//
//    
//    
//}
