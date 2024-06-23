//
//  FileDownloadService.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 23/06/24.
//

import Foundation

protocol FileDownloadServiceDelegate: URLSessionDownloadDelegate {
    func onDownloadError(error: Error)
}

struct FileDownloadService {
    func downloadFile(pathUrl: String?, delegate: FileDownloadServiceDelegate) {
        guard let pathUrl, let url = URL(string: pathUrl) else {
            delegate.onDownloadError(error: URLSession.InvalidURLRequestError())
            return
        }
        
        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: .main)
        var task: URLSessionDownloadTask?
        
        task = session.downloadTask(with: url)
        task?.resume()
    }
}
