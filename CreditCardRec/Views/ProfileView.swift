//
//  Views.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 2/26/25.
//

import SwiftUI

struct ProfileView: View {
    // User Data
    @EnvironmentObject var userData: UserData
    
    // The Core Data context from the environment.
    @Environment(\.managedObjectContext) private var viewContext
    
    //For overlay content
    let showOverlay: () -> Void
    
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
                        showOverlay()
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
                if userData.userCards.isEmpty {
                    Text("No cards added yet.")
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(userData.userCards, id: \.self) { card in
                            Text(card.name)
                        }
                        .onDelete(perform: deleteCard)
                    }
                    .listStyle(PlainListStyle())
                }
                
                Spacer()
            }
            .offset(y: 40)
                
            
        }
        
    }
    
    
    // Deletes cards from the user's list.
    private func deleteCard(at offsets: IndexSet) {
        userData.userCards.remove(atOffsets: offsets)
    }
}

struct Views_Previews: PreviewProvider {
    static var previews: some View {
        // For preview purposes, we inject a preview Core Data context.
        ProfileView(showOverlay: { })
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(UserData())
    }
}
