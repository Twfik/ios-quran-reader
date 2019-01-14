//
//  SuraDetailViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 13/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import SQLite

final class SuraDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ayats = [Ayats]()
    var words = [Words]()
    var viewModel: SuraDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(viewModel.sura.name.translation)"
        ayats = QuranDB.instance.getAyats(suraNumber: viewModel.sura.id)
        tableView.registerNib(AyahCell.self)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100
        navigationItem.setHidesBackButton(false, animated: true)
//    words = QuranDB.instance.getWords()
    }
    
    
}

extension SuraDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ayats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(AyahCell.self, indexPath: indexPath)
        cell.configure(sura: ayats[indexPath.row])
        return cell
    }
    
    
    
}
