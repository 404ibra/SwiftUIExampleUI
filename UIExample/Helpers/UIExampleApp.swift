//
//  UIExampleApp.swift
//  UIExample
//
//  Created by İbrahim Aktaş on 12.04.2023.
//

import SwiftUI

@main
struct UIExampleApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
    
