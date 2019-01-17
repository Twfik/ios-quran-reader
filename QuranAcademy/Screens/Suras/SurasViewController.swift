//
//  SurasViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 12/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class SurasViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var suras: [Sura]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        title = "Коран"
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1882352941, green: 0.4, blue: 0.6039215686, alpha: 1)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
}

//MARK: - Setup
extension SurasViewController {
    
    private func setup() {
        tableViewSetup()
        
    }
    
    private func tableViewSetup() {
        tableView.registerNib(ChapterCell.self)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100
    }
    
}

extension SurasViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suras.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sura = suras[indexPath.row]
        let cell = tableView.dequeue(ChapterCell.self, indexPath: indexPath)
        cell.configure(sura: sura)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let suraDetail = UIStoryboard.get(SuraDetailViewController.self)
        let viewModel = SuraDetailViewModel(sura: suras[indexPath.row])
        suraDetail.viewModel = viewModel
        push(suraDetail, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
