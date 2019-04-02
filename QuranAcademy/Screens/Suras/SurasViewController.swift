//
//  SurasViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 12/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class SurasViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: SurasViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        title = "Коран"
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.262745098, green: 0.3176470588, blue: 0.2196078431, alpha: 1)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        NotificationCenter.default.addObserver(forName: .kUpdateSuras, object: nil, queue: nil) { [unowned self] (_) in
            self.viewModel.updateSuras()
            self.collectionView.reloadData()
        }
        
    }
    
}

//MARK: - Setup
extension SurasViewController {
    
    private func setup() {
        collectionViewSetup()
        
    }
    
    private func collectionViewSetup() {
        collectionView.registerNib(ChapterCell.self)
    }
    
}

extension SurasViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftRightInsets: CGFloat = 16 * 2
        return CGSize(width: collectionView.bounds.width - leftRightInsets, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.suras.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sura = viewModel.suras[indexPath.row]
        let cell = collectionView.dequeue(ChapterCell.self, indexPath: indexPath)
        cell.configure(sura: sura)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let suraDetail = UIStoryboard.get(SuraDetailViewController.self)
        let viewModel = SuraDetailViewModel(sura: self.viewModel.suras[indexPath.row])
        suraDetail.viewModel = viewModel
        
        self.push(suraDetail, animated: true)
        self.collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
