//
//  SearchBar.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 23/06/24.
//

import SwiftUI

struct SearchBar: View {
    @State var searchText: String = ""
    @State private var navigate: Bool = false
    
    var onEditingChanged: (Bool) -> Void
    var destination: (String) -> SearchResultsView
    
    var body: some View {
        HStack {
            TextField(
                "Buscar no Mercado Livre",
                text: $searchText,
                onEditingChanged: { isEditing in
                    onEditingChanged(isEditing)
                },
                onCommit: {
                    navigate = true
                }
            )
            .textFieldStyle(.roundedBorder)
            .cornerRadius(25)
            .padding()
            
            NavigationLink(isActive: $navigate) {
                destination(searchText)
            } label: {
                EmptyView()
            }
        }
        .background(Color.yellow)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        let items = try? MeliItem.getMocks()
        let itemResults: Result<[MeliItem], Error> = .success(items ?? [])
        
        SearchBar(
            onEditingChanged: {_ in
                
            }, destination: {_ in
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
        )
    }
}
