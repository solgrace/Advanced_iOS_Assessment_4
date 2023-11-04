//
//  IOS_Advanced_Assignment_4App.swift
//  IOS_Advanced_Assignment_4
//
//  Created by vinay bayyapunedi on 25/10/23.
//

import SwiftUI

@main
struct IOS_Advanced_Assignment_4App: App {
    
    @StateObject private var modelData = ModelData()
    
    init() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ModelData())
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
