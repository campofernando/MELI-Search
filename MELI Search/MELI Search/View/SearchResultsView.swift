//
//  SearchResultsView.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 22/06/24.
//

import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var viewModel: MeliSearchViewModel
    var searchText: String
    
    init(viewModel: MeliSearchViewModel, searchText: String) {
        self.viewModel = viewModel
        self.searchText = searchText
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.searchResultItems, id: \.itemId) { item in
                ItemCard(item: item, parentViewModel: viewModel)
            }
            .listStyle(PlainListStyle())
        }
        .background(Color.yellow)
        .navigationBarTitle("Mercado Livre")
        .onAppear {
            viewModel.searchItems(withText: searchText)
        }
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        let items = try? MeliItem.getMocks()
        let itemResults: Result<[MeliItem], Error> = .success(items ?? [])
        
        SearchResultsView(
            viewModel: MeliSearchViewModel(
                meliSearch: MeliSearchMock(
                    itemsResult: itemResults,
                    lastSearches: .success(["Busca 1, Busca 2"])
                )
            ),
            searchText: "Busca"
        )
    }
}
