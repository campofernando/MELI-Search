//
//  FileDownloadManager.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 23/06/24.
//

import Foundation

protocol FileDownloadManagerDelegate: NSObject {
    func onDownloadCompleted(result: Result<URL, Error>)
}

class FileDownloadManager: NSObject {
    private var itemPath: String?
    private let downloadService = FileDownloadService()
    private weak var delegate: FileDownloadManagerDelegate?
    
    init(delegate: FileDownloadManagerDelegate) {
        self.delegate = delegate
    }
    
    func startDownload(itemPath: String?) {
        self.itemPath = itemPath
        downloadService.downloadFile(pathUrl: itemPath, delegate: self)
    }
    
    private func getLocalPath(url: URL) -> URL? {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
    }
}

extension FileDownloadManager: FileDownloadServiceDelegate {
    func onDownloadError(error: Error) {
        delegate?.onDownloadCompleted(result: .failure(error))
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        guard let publicPath = itemPath,
              let url = URL(string: publicPath),
              let localDestinationUrl = getLocalPath(url: url) else {
            onDownloadError(error: URLSession.InvalidURLRequestError())
            return
        }
        
        do {
            if FileManager.default.fileExists(atPath: localDestinationUrl.relativePath) {
                try FileManager.default.removeItem(atPath: localDestinationUrl.relativePath)
            }
            try FileManager.default.moveItem(at: location, to: localDestinationUrl)
            delegate?.onDownloadCompleted(result: .success(localDestinationUrl))
        } catch {
            onDownloadError(error: error)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error {
            onDownloadError(error: error)
        }
    }
}

