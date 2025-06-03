import XCTest
@testable import FoodSaver

private extension MainViewModel {
    func filtered(items: [FoodItem]) -> [FoodItem] {
        var filtered = items
        if !searchText.isEmpty {
            switch selectedCategory {
            case "Name":
                filtered = filtered.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            case "Category":
                filtered = filtered.filter { $0.category.localizedCaseInsensitiveContains(searchText) }
            case "Location":
                filtered = filtered.filter { $0.location.localizedCaseInsensitiveContains(searchText) }
            default:
                break
            }
        }
        if selectedStatus != "All" {
            filtered = filtered.filter { $0.status.rawValue == selectedStatus }
        }
        return filtered.sorted { $0.name < $1.name }
    }
}

final class MainViewModelFilterTests: XCTestCase {
    func testFilterByNameAndStatus() {
        let items = [
            FoodItem(name: "Apple", bestBeforeDate: Date(), category: "Produce", location: "Fridge", warningPeriod: 1),
            FoodItem(name: "Banana", bestBeforeDate: Date(), category: "Produce", location: "Fridge", warningPeriod: 1)
        ]
        let vm = MainViewModel()
        vm.searchText = "ban"
        vm.selectedCategory = "Name"
        vm.selectedStatus = "All"
        let result = vm.filtered(items: items)
        XCTAssertEqual(result.map(\.$name), ["Banana"])
    }

    func testFilterByStatus() {
        let expired = FoodItem(name: "Old", bestBeforeDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, category: "", location: "", warningPeriod: 1)
        let fresh = FoodItem(name: "Fresh", bestBeforeDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!, category: "", location: "", warningPeriod: 1)
        let vm = MainViewModel()
        vm.selectedStatus = "Expired"
        let result = vm.filtered(items: [expired, fresh])
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Old")
    }
}
