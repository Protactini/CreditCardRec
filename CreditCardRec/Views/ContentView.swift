//
//  ContentView.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 2/26/25.
//

import SwiftUI

struct ContentView: View {
    //User data
    @EnvironmentObject var userData: UserData
    
    // Controls the animation state (e.g. slide in/out)
    @State private var showSearchOverlay = false
    // For overlay drag offset
    @State private var dragOffset: CGFloat = 0.0
    // Namespace for matched‐geometry effects for cards
    @Namespace private var rootAnimation
    
    
    @State private var selectedTab = 0
    let maxTab = 1 // e.g. two tabs: indices 0 and 1

     
    var body: some View {
        ZStack{
            TabView(selection: $selectedTab) {
                CardsView(showOverlay: showOverlay, animation: rootAnimation)
                    .tabItem {
                        Image(systemName: "creditcard")
                        Text("Cards")
                    }
                    .tag(0)
                
                FindBestCardView(rootAnimation: rootAnimation)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Find Best Card")
                    }
                    .tag(1)
            }
            .tabViewStyle(DefaultTabViewStyle())
            .animation(.easeInOut(duration: 1), value: selectedTab)  // 0.8s duration
//            .gesture(
//              DragGesture().onEnded { value in
//                if value.translation.width < -50 {
//                  // left swipe → next tab
//                  withAnimation { selectedTab = min(selectedTab + 1, maxTab) }
//                } else if value.translation.width > 50 {
//                  // right swipe → previous tab
//                  withAnimation { selectedTab = max(selectedTab - 1, 0) }
//                }
//              }
//            )
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
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(UserData())
}
