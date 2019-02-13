//
//  LoadingProgressViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 11/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class DownloadViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var message = ""
    var viewModel: DownloadViewModel!
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        viewModel.cancelRequest()
        dismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate(view: containerView, on: true, scale: 0.85)
    }
    
    
}

//MARK: - Setup
extension DownloadViewController {
    
    private func setup() {
        setupContainerAppear()
        setupLabels()
        setupProgressView()
        fetchDownloadFile()
    }
    
    private func fetchDownloadFile() {
        guard let url = URL(string: viewModel.url) else { return }
        viewModel.downloadFile(with: url, viewModel.fileName)
    }
    
    private func setupContainerAppear() {
        containerView.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        containerView.alpha = 0
    }
    
    private func dismiss() {
        animate(view: containerView, on: false, scale: 0.85) {
            self.dismiss(animated: false)
        }
    }
    
    private func setupProgressView() {
        viewModel.progress.subscribe(onNext: { [weak self] (progress) in
            self?.setProgressView(value: progress)
            guard progress == 1.0 else { return }
            self?.progressViewFinished()
        }).disposed(by: bag)
    }
    
    private func setProgressView(value: Float) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.progressView.setProgress(value, animated: true)
            })
        }
    }
    
    private func progressViewFinished() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.dismiss()
        }
    }
    
    private func setupLabels() {
        messageLabel.text = message
    }
    
}
