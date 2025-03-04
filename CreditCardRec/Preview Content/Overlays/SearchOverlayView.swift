//
//  SearchOverlayView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 3/4/25.
//
import SwiftUI

struct SearchOverlayView: View {
    
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
    
    // Inharitent veriables from profile view
    @Binding var userCards: [String]
    @Binding var showSearchOverlay: Bool

    var body: some View {
        VStack(spacing: 20) {
            // Drag handle indicator
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
            Spacer()
        }
        // Set the overlay to cover 80% of the screen height.
        .frame(height: UIScreen.main.bounds.height * 0.9)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        // Position the overlay so that the top 20% of the screen (original page) remains visible.
        .padding(.top, UIScreen.main.bounds.height * 0.2)
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
    
}

struct SearchOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        // For preview purposes, we inject a preview Core Data context.
        ProfileView(userCards: .constant([]), showSearchOverlay: .constant(true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
