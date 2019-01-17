//
//  ViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit


class IntroViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        let surasVC = UIStoryboard.get(SurasViewController.self)
        surasVC.suras = viewModel.suras
        push(surasVC, animated: true)
    }
    var viewModel: IntroViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.shadowImage = UIImage()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

}

//MARK: - Setup
extension IntroViewController {
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        let headerView = UIView()
        let headerLabel = UILabel()
        let headerText = "Выберите перевод"
        let textSize: CGFloat = 24
        let padding: CGFloat = 20
        // Расчет высоты заголовка в зависимости от длины текста с padding
        let maxSize = CGSize(width: tableView.bounds.width - padding * 2, height: CGFloat.infinity)
        let textBoundingRect = (headerText as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: textSize)], context: nil).height.rounded(.up)
        let headerViewHeight = textBoundingRect + padding * 2

        headerView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: headerViewHeight)
        headerLabel.frame = CGRect(x: 0, y: 0, width: headerView.bounds.width, height: headerView.bounds.height)
        headerLabel.textAlignment = .center
        headerLabel.numberOfLines = 0
        headerLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        headerLabel.font = UIFont.systemFont(ofSize: textSize)
        headerLabel.text = headerText
        
        headerView.addSubview(headerLabel)
        tableView.tableHeaderView = headerView
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }
    
    
    private func showProgressView(message: String) {
        let loadingProgressVC = UIStoryboard.get(DownloadViewController.self)
        loadingProgressVC.modalPresentationStyle = .overCurrentContext
        loadingProgressVC.modalTransitionStyle = .crossDissolve
        loadingProgressVC.message = message
        let viewModel = DownloadViewModel()
        loadingProgressVC.viewModel = viewModel
        present(loadingProgressVC, animated: true)
    }
    
    private func fetchSuras() {
        viewModel.getSuras()
            .subscribe(onNext: { [weak self] (suras) in
                self?.viewModel.suras = suras.suras
                }, onError: { (error) in
                    print(error)
            }).disposed(by: bag)
    }

}

extension IntroViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let selectedView = UIView(frame: cell.bounds)
        selectedView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        cell.selectedBackgroundView = selectedView

        cell.textLabel?.text = viewModel.languages[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let language = viewModel.languages[indexPath.row]
        let code = language.code
        UserDefaults.standard.set(code, forKey: Keys.kLocaleCode)
        DispatchQueue.main.async {
            self.fetchSuras()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
}

