//
//  HomeView.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 18/06/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: MeliSearchViewModel
    
    @State var showPreviousSearches: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(
                    onEditingChanged: { isEditing in
                        showPreviousSearches = isEditing
                    },
                    destination: { searchText in
                        SearchResultsView(viewModel: viewModel, searchText: searchText)
                    }
                )
                
                List {
                    ForEach(viewModel.defaultCategoryItems, id: \.itemId) { item in
                        if let itemId = item.itemId {
                            Text(itemId)
                        }
                    }
                }
            }
            .alert(viewModel.modalErrorText ?? "Mercado Livre",
                   isPresented: $viewModel.isShowingModal,
                   actions: {
                Button("OK") {
                    viewModel.isShowingModal = false
                }
            })
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle("Mercado Livre")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let items = try? MeliItem.getMocks()
        let itemResults: Result<[MeliItem], Error> = .success(items ?? [])
        
        HomeView(
            viewModel: MeliSearchViewModel(
                meliSearch: MeliSearchMock(
                    itemsResult: itemResults,
                    lastSearches: .success(["Busca 1, Busca 2"])
                )
            )
        )
    }
}
