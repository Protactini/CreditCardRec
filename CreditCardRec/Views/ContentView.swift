//
//  ContentView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 2/26/25.
//

import SwiftUI

struct ContentView: View {
    // User's Card Array
//    @State private var userCards: [Card] = []
    // Controls the animation state (e.g. slide in/out)
    @State private var showSearchOverlay = false
    // For overlay drag offset
    @State private var dragOffset: CGFloat = 0.0
     
    var body: some View {
        ZStack{
            TabView {
                CardsView(showOverlay: showOverlay)
                    .tabItem {
                        Image(systemName: "creditcard")
                        Text("Cards")
                    }
                
                FindBestCardView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Find Best Card")
                    }
//                
//                ProfileView(showOverlay: showOverlay)
//                    .tabItem {
//                        Image(systemName: "person.crop.circle")
//                        Text("Profile")
//                    }
            }
            .zIndex(0)
            
            // MARK: Overlay Section
            if showSearchOverlay {
                // Semi-transparent background that covers the whole screen.
                // Tapping it dismisses the overlay.
                Color.black.opacity(0.1)
                    .ignoresSafeArea()
                    .onTapGesture {
                        dismissOverlay()
                    }
                    .zIndex(1)

                // Search overlay view
                SearchOverlayView(dismissOverlay: dismissOverlay)
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
                        if gesture.translation.height > 200 {
                            dismissOverlay()
                        } else {
                            // Snap back if not dragged far enough
                            withAnimation(.easeInOut(duration: 0.3)) {
                                dragOffset = 0
                            }
                        }
                    }
                )
                .zIndex(2)
            }
        }
    }
    
    /*-------------------------------------------------------------------------------
     --------------------------------------------------------------------------------
     ------------------------Display Functions for overlays--------------------------
     --------------------------------------------------------------------------------
     --------------------------------------------------------------------------------
     --------------------------------------------------------------------------------
     --------------------------------------------------------------------------------
     */
    // Mark: Dismiss overlay function
    private func dismissOverlay() {
        // Animate the overlay sliding down off the screen.
        withAnimation(.easeInOut(duration: 0.3)) {
            dragOffset = UIScreen.main.bounds.height
        }
        // After the slide-out animation completes, remove the overlay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.3)) {
                showSearchOverlay = false
                dragOffset = 0
            }
        }
    }
    //Dismiss overlay function
    private func showOverlay() {
        // Animate the overlay sliding up screen.
        withAnimation(
        .interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
            showSearchOverlay = true
        }
    }
}



#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
