//
//  HomeViewModel.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 22/06/24.
//

import Foundation
import SwiftUI

class MeliSearchViewModel: NSObject, ObservableObject {
    let meliSearch: MeliSearchProtocol
    private lazy var fileDownloadManager = FileDownloadManager(delegate: self)
    
    @Published var defaultCategoryItems = [MeliItem]()
    @Published var lastSearches = [String]()
    @Published var recentlySearchedItems = [MeliItem]()
    @Published var recentlyViewedItems = [MeliItem]()
    @Published var searchResultItems = [MeliItem]()
    @Published var isShowingModal: Bool = false
    @Published var itemDescription: String = ""
    @Published var image: UIImage? = nil
    
    var modalErrorText: String?
    
    init(meliSearch: MeliSearchProtocol) {
        self.meliSearch = meliSearch
        super.init()
        self.loadDefaultItems()
    }
    
    func loadDefaultItems() {
        self.meliSearch.loadDefaultItems { [weak self] result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self?.defaultCategoryItems = items
                }
            case .failure(let error):
                self?.onError(error: error)
            }
        }
    }
    
    func onSearchTapped() {
        let result = meliSearch.getLastSearches()
        switch result {
        case .success(let searches):
            lastSearches = searches
        case .failure(let error):
            onError(error: error)
        }
    }
    
    func searchItems(withText searchText: String) {
        meliSearch.searchItems(withText: searchText) { [weak self] result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self?.searchResultItems = items
                }
            case .failure(let error):
                self?.onError(error: error)
            }
        }
    }
    
    func getItemDescription(withId itemId: String) {
        meliSearch.getItemDescription(itemId: itemId) { [weak self] result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    self?.itemDescription = description
                }
            case .failure(let error):
                self?.onError(error: error)
            }
        }
    }
    
    func downloadImageforItem(atPath itemPath: String?) {
        fileDownloadManager.startDownload(itemPath: itemPath)
    }
    
    func onError(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.modalErrorText = "Error: \(error)"
            self?.isShowingModal = true
        }
    }
}

extension MeliSearchViewModel: FileDownloadManagerDelegate {
    func onDownloadCompleted(result: Result<URL, Error>) {
        switch result {
        case .success(let url):
            loadImage(fromLocalPath: url)
        case .failure(let error):
            onError(error: error)
        }
    }
    
    func loadImage(fromLocalPath imagePath: URL) {
        if FileManager.default.fileExists(atPath: imagePath.relativePath) {
            let loadedImage = UIImage(contentsOfFile: imagePath.relativePath)
            self.image = loadedImage
        }
    }
}
