//
//  Views.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 2/26/25.
//

import SwiftUI

struct ProfileView: View {
    // The Core Data context from the environment.
    @Environment(\.managedObjectContext) private var viewContext
    
    //For User
    @Binding var userCards: [Card]
    //For overlay content
    @Binding var showSearchOverlay: Bool
    
    var body: some View {
        NavigationView{
            // MARK: Cards Page Content
            VStack {
                HStack{
                    Text("Your Wallet")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .offset(x: 5)
                    
                    // MARK: Add Buttong for search page
                    Button {
                        withAnimation(
                            .interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                                showSearchOverlay = true
                            }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding(9)
                            .background(.black, in: Circle())
                    }
                    .offset(x: -20)
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
                            Text(card.name)
                        }
                        .onDelete(perform: deleteCard)
                    }
                    .listStyle(PlainListStyle())
                }
                
                Spacer()
            }
//            .navigationTitle("Profile")
//            .toolbar {
//                // Provides an Edit button to enable deletion.
//                EditButton()
//            }
            .offset(y: 40)
                
            
        }
        
    }
    
    
    // Deletes cards from the user's list.
    private func deleteCard(at offsets: IndexSet) {
        userCards.remove(atOffsets: offsets)
    }
}

struct Views_Previews: PreviewProvider {
    static var previews: some View {
        // For preview purposes, we inject a preview Core Data context.
        ProfileView(userCards: .constant([]), showSearchOverlay: .constant(true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
