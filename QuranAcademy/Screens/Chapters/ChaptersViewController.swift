//
//  SurasViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 12/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import RxSwift

final class ChaptersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ChaptersViewModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        title = "Коран"
        
        NotificationCenter.default.addObserver(forName: .kUpdateSuras, object: nil, queue: nil) { [unowned self] (_) in
            self.viewModel.updateSuras()
            self.collectionView.reloadData()
        }
        
        Theme.themeWasChanged
            .startWith(())
            .withUnretained(self)
            .subscribe(onNext: { (vc, _) in
                vc.collectionView.backgroundColor = Theme.current.collectionViewBackgroundColor
                vc.collectionView.reloadData()
            }).disposed(by: bag)
        
    }
    
}

//MARK: - Setup
extension ChaptersViewController {
    
    private func setup() {
        collectionViewSetup()
        
    }
    
    private func collectionViewSetup() {
        collectionView.registerNib(ChapterCell.self)
    }
    
}

extension ChaptersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        let sura = viewModel.suras[indexPath.item]
        let unicode = viewModel.suraNamesUnicodes[indexPath.item]
        let cell = collectionView.dequeue(ChapterCell.self, indexPath: indexPath)
        cell.configure(sura: sura, unicode: unicode)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let suraDetail = UIStoryboard.get(SuraViewController.self)
        let viewModel = SuraViewModel(sura: self.viewModel.suras[indexPath.row])
        suraDetail.viewModel = viewModel
        
        self.push(suraDetail, animated: true)
        self.collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
