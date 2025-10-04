//
//  NodaApp.swift
//  Noda
//
//  Created by Александр on 03.10.2025.
//

import SwiftUI
import SwiftData

@main
struct NodaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Note.self)
    }
}
