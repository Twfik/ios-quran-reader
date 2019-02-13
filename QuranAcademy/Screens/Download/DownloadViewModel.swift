//
//  LoadingProgressView.swift
//  QuranAcademy
//
//  Created by Ayub on 11/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import Alamofire
import RxSwift
import RxCocoa
import Moya

final class DownloadViewModel {
    
    private var provider = MoyaProvider<QuranEndpoint>()
    private var request: Alamofire.Request?
    var progress = BehaviorRelay(value: Float())
    var fileName = ""
    var url = ""
    
    
    
    func downloadFile(with url: URL,_ fileName: String) {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        request = download(url, to: destination)
            .downloadProgress { [weak self] (progress) in
                let progress = Float(progress.fractionCompleted)
                self?.progress.accept(progress)
            }
            .responseData { (data) in
                switch data.result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                print(data.description)
        }
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
}
