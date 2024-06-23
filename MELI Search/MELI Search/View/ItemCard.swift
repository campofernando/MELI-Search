//
//  ItemCard.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 23/06/24.
//

import SwiftUI

struct ItemCard: View {
    @ObservedObject var parentViewModel: MeliSearchViewModel
    @ObservedObject var viewModel: MeliItemCard
    
    let item: MeliItem
    
    init(item: MeliItem, parentViewModel: MeliSearchViewModel) {
        self.item = item
        self.viewModel = MeliItemCard(meliItem: item)
        self.parentViewModel = parentViewModel
        viewModel.downloadImage()
    }
    
    var body: some View {
        HStack {
            if let itemId = item.itemId, let title = item.title {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .padding()
                }
                NavigationLink(title) {
                    ItemDetailsView(
                        viewModel: parentViewModel,
                        title: title,
                        itemId: itemId,
                        itemPath: item.thumbnail
                    )
                }
            }
        }
    }
}

//struct ItemCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemCard()
//    }
//}
