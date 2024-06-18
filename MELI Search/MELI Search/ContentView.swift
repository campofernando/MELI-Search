//
//  ContentView.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 18/06/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        Text("Hello world!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
