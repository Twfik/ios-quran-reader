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

typealias Success = Bool
typealias Cancelled = Bool

final class DownloadViewModel {
    
    private var provider = MoyaProvider<QuranEndpoint>()
    private var request: Alamofire.Request?
    var progress = BehaviorRelay(value: Float())
    var fileName = ""
    var url = ""
    var action: ((Success?, Error?, Cancelled?) -> Void)?
    
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
            .responseData { [weak self] (data) in
                switch data.result {
                case .success(let data):
                    self?.action?(true, nil, nil)
                    print(data)
                case .failure(let error):
                    self?.action?(nil, error, nil)
                    print(error.localizedDescription)
                }
                
                print(data.description)
        }
    }
    
    func cancelRequest() {
        action?(nil, nil, true)
        request?.cancel()
    }
    
}
