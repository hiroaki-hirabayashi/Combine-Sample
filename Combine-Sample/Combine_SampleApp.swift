//
//  Combine_SampleApp.swift
//  Combine-Sample
//
//  Created by Hiroaki-Hirabayashi on 2022/03/17.
//

import SwiftUI

@main
struct Combine_SampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
