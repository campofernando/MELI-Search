//
//  HomeViewModel.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 22/06/24.
//

import Foundation
import SwiftUI

class MeliSearchViewModel: ObservableObject {
    let meliSearch: MeliSearchProtocol
    
    @Published var defaultCategoryItems = [MeliItem]()
    @Published var lastSearches = [String]()
    @Published var recentlySearchedItems = [MeliItem]()
    @Published var recentlyViewedItems = [MeliItem]()
    @Published var searchResultItems = [MeliItem]()
    @Published var isShowingModal: Bool = false
    
    var modalErrorText: String?
    
    init(meliSearch: MeliSearchProtocol) {
        self.meliSearch = meliSearch
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
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func onSearchTapped() {
        let result = meliSearch.getLastSearches()
        switch result {
        case .success(let searches):
            lastSearches = searches
        case .failure(let error):
            fatalError(error.localizedDescription)
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
    
    func onError(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.modalErrorText = "Error: \(error)"
            self?.isShowingModal = true
        }
    }
}
