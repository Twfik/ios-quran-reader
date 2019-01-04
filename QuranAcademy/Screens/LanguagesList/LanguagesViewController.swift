//
//  ViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

class LanguagesViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: LanguagesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate(view: containerView, on: true)
    }

}

//MARK: - Setup
extension LanguagesViewController {
    
    private func setup() {
        setupContainerView()
    }
    
    private func setupContainerView() {
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
        containerView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        containerView.alpha = 0
    }
    
}

extension LanguagesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.languages[indexPath.row].name
        return cell
    }
    
}

