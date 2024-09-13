import SwiftUI

struct FoodItemRow: View {
    let foodItem: FoodItem

    /// Calculates the background color based on the item's status.
    private func backgroundColor() -> Color {
        switch foodItem.status {
        case .expired:
            return Color.red.opacity(0.2) // Light red background for expired items
        case .expiring:
            return Color.yellow.opacity(0.2) // Light yellow background for expiring items
        case .fresh:
            return Color.green.opacity(0.2) // Light green background for fresh items
        }
    }

    var body: some View {
        HStack {
            Text(foodItem.name)
                .font(Theme.headlineFont)
                .foregroundColor(Theme.primaryColor)
            Spacer()
            Text(foodItem.category)
                .font(Theme.bodyFont)
                .foregroundColor(Theme.secondaryColor)
            Spacer()
            Text(foodItem.location)
                .font(Theme.bodyFont)
                .foregroundColor(Theme.secondaryColor)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(backgroundColor())
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
        )
        .padding(.vertical, 5)
        .animation(.spring(), value: foodItem)
    }
}

struct FoodItemRow_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemRow(foodItem: FoodItem(name: "Apple", bestBeforeDate: Date(), category: "Fresh Produce", location: "Fridge", warningPeriod: 3))
    }
}
