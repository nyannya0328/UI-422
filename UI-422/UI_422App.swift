//
//  UI_422App.swift
//  UI-422
//
//  Created by nyannyan0328 on 2022/01/14.
//

import SwiftUI

@main
struct UI_422App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
