import SwiftUI
import Combine

@MainActor
class MainViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedCategory: String = "Name"
    @Published var selectedStatus: String = "All"
    @Published var selectedFoodItem: FoodItem?
    @Published var isShowingEditView: Bool = false
    @Published var confettiCounter: Int = 0

    func triggerConfetti() {
        confettiCounter += 1
    }
}
