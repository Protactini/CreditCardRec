//
//  ProfileView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 2/26/25.
//

import SwiftUI

struct ProfileView: View {
    // The Core Data context from the environment.
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch all available cards from Core Data (the "database").
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Cards.credit_card, ascending: true)],
        animation: .default)
    private var availableCards: FetchedResults<Cards>
    
    // Local state for search text, search results (as card names) and the user's added cards.
    @State private var searchText: String = ""
    @State private var searchResults: [String] = []
    @State private var userCards: [String] = []
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar for entering a card name.
                TextField("Enter card name", text: $searchText, onEditingChanged: { _ in
                    filterResults()
                }, onCommit: {
                    filterResults()
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                
                // Display search results if there are any.
                if !searchResults.isEmpty {
                    List(searchResults, id: \.self) { cardName in
                        Button(action: {
                            addCard(cardName)
                        }) {
                            Text(cardName)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                
                Divider().padding()
                
                // Section showing the user's added cards.
                Text("Your Cards")
                    .font(.headline)
                if userCards.isEmpty {
                    Text("No cards added yet.")
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(userCards, id: \.self) { card in
                            Text(card)
                        }
                        .onDelete(perform: deleteCard)
                    }
                    .listStyle(PlainListStyle())
                }
                
                Spacer()
            }
            .navigationTitle("Profile")
            .toolbar {
                // Provides an Edit button to enable deletion.
                EditButton()
            }
        }
    }
    
    // Filters availableCards (fetched from Core Data) based on the search text.
    private func filterResults() {
        if searchText.isEmpty {
            searchResults = []
        } else {
            searchResults = availableCards.compactMap { card in
                guard let name = card.credit_card else { return nil }
                return name.lowercased().contains(searchText.lowercased()) ? name : nil
            }
        }
    }
    
    // Adds a card name to the user's list if it isn't already present.
    private func addCard(_ card: String) {
        if !userCards.contains(card) {
            userCards.append(card)
        }
        // Clear the search fields.
        searchText = ""
        searchResults = []
    }
    
    // Deletes cards from the user's list.
    private func deleteCard(at offsets: IndexSet) {
        userCards.remove(atOffsets: offsets)
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        // For preview purposes, we inject a preview Core Data context.
        ProfileView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
