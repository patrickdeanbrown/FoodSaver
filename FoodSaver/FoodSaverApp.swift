import SwiftUI

@main
struct FoodSaverApp: App {
    @StateObject private var viewModel = FoodViewModel()
    @State private var isDataLoaded = false

    var body: some Scene {
        WindowGroup {
            if isDataLoaded {
                MainView()
                    .environmentObject(viewModel)
            } else {
                SplashScreen()
                    .onAppear {
                        loadData()
                    }
            }
        }
    }

    private func loadData() {
        DispatchQueue.global(qos: .userInitiated).async {
            viewModel.fetchFoodItems()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isDataLoaded = true
            }
        }
    }
}
