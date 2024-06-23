//
//  MeliItemCard.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 23/06/24.
//

import Foundation
import SwiftUI

class MeliItemCard: NSObject, ObservableObject {
    private lazy var fileDownloadManager = FileDownloadManager(delegate: self)
    var meliItem: MeliItem
    @Published var image: UIImage? = nil
    
    init(meliItem: MeliItem) {
        self.meliItem = meliItem
    }
    
    func downloadImage() {
        fileDownloadManager.startDownload(itemPath: meliItem.thumbnail)
    }
}

extension MeliItemCard: FileDownloadManagerDelegate {
    func onDownloadCompleted(result: Result<URL, Error>) {
        switch result {
        case .success(let url):
            loadImage(fromLocalPath: url)
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func loadImage(fromLocalPath imagePath: URL) {
        if FileManager.default.fileExists(atPath: imagePath.relativePath) {
            let loadedImage = UIImage(contentsOfFile: imagePath.relativePath)
            image = loadedImage
        } else {
            fatalError()
        }
    }
}
