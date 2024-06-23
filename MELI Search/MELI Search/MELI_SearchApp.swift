//
//  MELI_SearchApp.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 18/06/24.
//

import SwiftUI

@main
struct MELI_SearchApp: App {
    let persistenceController: PersistenceController
    let httpClient: HttpClient
    let meliSearch: MeliSearchProtocol
    let homeViewModel: MeliSearchViewModel
    
    init() {
        persistenceController = PersistenceController.shared
        httpClient = URLSession(configuration: .default)
        let apiService = MeliItemsService(httpClient: httpClient)
        let dbService = MeliSearchDataService(context: persistenceController.container.viewContext)
        meliSearch = MeliSearch(apiService: apiService, dbService: dbService)
        homeViewModel = MeliSearchViewModel(meliSearch: meliSearch)
    }

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: homeViewModel)
        }
    }
}
