import SwiftUI
import SwiftData

@main
struct FoodSaverApp: App {

    private let modelContainer: ModelContainer = {
        do {
            return try ModelContainer(for: FoodItem.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(modelContainer)
        }
    }
}
