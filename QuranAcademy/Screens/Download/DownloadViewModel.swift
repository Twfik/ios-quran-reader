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
    
    var provider = MoyaProvider<QuranEndpoint>()
    var progress = BehaviorRelay(value: Float())

    var request: Alamofire.Request?
    let destination: DownloadRequest.DownloadFileDestination = { _, _ in
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("quranDB.db")
        return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
    }
    
    /// Возвращает адрес файла БД с текстами Корана
    func getQuranDatabaseURL() -> Single<URL?> {
        return provider.rx
            .request(.getQuranTextURL)
            .retry(5)
            .map { response in
              guard let jsonObject = try? JSONSerialization.jsonObject(with: response.data, options: []),
                var dict = jsonObject as? Dictionary<String?, String>,
                let stringURL = dict["file_url"],
                let url = URL(string: stringURL) else { return nil }
                return url
        }
    }
    
    /// Возвращает файл БД с текстами Корана
    func getQuranDatabase(with url: URL) {
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
