//
//  SearchOverlayView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 3/4/25.
//
import SwiftUI

struct SearchOverlayView: View {
    
    // Local state for search text and search results (now as Card objects).
    @State private var searchText: String = ""
    @State private var searchResults: [Card] = []
    
    // Binding now holds an array of Card objects.
    let dismissOverlay: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            // Drag handle indicator.
            Capsule()
                .frame(width: 40, height: 6)
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.top, 10)

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
            // Update search results whenever searchText changes.
            .onChange(of: searchText) { _ in
                filterResults()
            }

            // Display search results if there are any.
            if !searchResults.isEmpty {
                List(searchResults, id: \.id) { card in
                    Button(action: {
                        addCard(card)
                        dismissOverlay()
                    }) {
                        Text(card.name)
                    }
                }
                .listStyle(PlainListStyle())
            }
            Spacer()
        }
        // Set the overlay to cover 95% of the screen height.
        .frame(height: UIScreen.main.bounds.height * 0.95)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        // Position the overlay so that the top 20% of the screen remains visible.
        .padding(.top, UIScreen.main.bounds.height * 0.2)
    }
    
    // Filters the global 'cards' array based on the search text and returns Card objects.
    private func filterResults() {
        if searchText.isEmpty {
            searchResults = []
        } else {
            searchResults = cards.filter { card in
                card.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    // Adds a Card to the user's list if it isn't already present.
    private func addCard(_ card: Card) {
        if !userCards.contains(card) {
            userCards.append(card)
        }
        // Clear the search fields.
        searchText = ""
        searchResults = []
    }
}

struct SearchOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        // For preview purposes, we inject a preview Core Data context.
        SearchOverlayView(dismissOverlay: { })
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
