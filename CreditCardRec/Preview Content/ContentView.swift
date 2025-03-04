//
//  ContentView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 2/26/25.
//

import SwiftUI

struct ContentView: View {
    //User's Card Array
    @State private var userCards: [String] = []
    //For overlay content
    @State private var showSearchOverlay = false
    @State private var dragOffset: CGFloat = 0.0
    
    var body: some View {
        ZStack{
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
                
                ProfileView(userCards: self.$userCards,
                    showSearchOverlay: $showSearchOverlay)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
            }
            
            // MARK: Overlay Section
            if showSearchOverlay {
                // Semi-transparent background that covers the whole screen.
                // Tapping it dismisses the overlay.
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showSearchOverlay = false
                        }
                    }

                // Search overlay view
                SearchOverlayView(userCards: self.$userCards,
                    showSearchOverlay: $showSearchOverlay)
                    .offset(y: dragOffset)
                    .transition(.move(edge: .bottom))
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                // Allow dragging only downward
                                if gesture.translation.height > 0 {
                                    dragOffset = gesture.translation.height
                                }
                            }
                            .onEnded { gesture in
                                // If dragged down enough, dismiss the overlay.
                                if gesture.translation.height > 100 {
                                    withAnimation {
                                        showSearchOverlay = false
                                        dragOffset = 0
                                    }
                                } else {
                                    // Snap back if not dragged far enough
                                    withAnimation {
                                        dragOffset = 0
                                    }
                                }
                            }
                    )
            }
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
