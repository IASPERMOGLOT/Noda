import SwiftUI
import SwiftData

@main
struct NodaApp: App {
    let modelContainer: ModelContainer
    
    init () {
        do {
            modelContainer = try ModelContainer(for: Note.self)
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
