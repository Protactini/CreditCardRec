//
//  CreditCardRecApp.swift
//  CreditCardRec
//
//  Created by Hongzhi ZHU on 2/26/25.
//

import SwiftUI

@main
struct CreditCardRecApp: App {
    let persistenceController = PersistenceController.shared
    
    @StateObject private var userData = UserData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(userData)
        }
    }
}
