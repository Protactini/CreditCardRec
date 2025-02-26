//
//  ContentView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 2/26/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CardsView()
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Cards")
                }
            
            FindBestCardView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Find Best Card")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
