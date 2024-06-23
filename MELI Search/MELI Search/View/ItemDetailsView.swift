//
//  ItemDetailsView.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 23/06/24.
//

import SwiftUI

struct ItemDetailsView: View {
    @ObservedObject var viewModel: MeliSearchViewModel
    
    let title: String
    let itemId: String
    
    var body: some View {
        VStack {
            Text(title)
            ScrollView {
                Text(viewModel.itemDescription)
            }
        }
        .padding()
        .onAppear {
            viewModel.getItemDescription(withId: itemId)
        }
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let items = try? MeliItem.getMocks()
        let itemResults: Result<[MeliItem], Error> = .success(items ?? [])
        
        ItemDetailsView(
            viewModel: MeliSearchViewModel(
                meliSearch: MeliSearchMock(
                    itemsResult: itemResults,
                    lastSearches: .success(["Busca 1, Busca 2"])
                )
            ),
            title: "Mesa de jantar",
            itemId: "MLB2040426998"
        )
    }
}
