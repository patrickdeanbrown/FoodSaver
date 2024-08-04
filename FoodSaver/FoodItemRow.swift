import SwiftUI

struct FoodItemRow: View {
    let foodItem: FoodItem

    var body: some View {
        HStack {
            Text(foodItem.name)
                .font(.headline)
            Spacer()
            Text(foodItem.category)
                .font(.subheadline)
            Spacer()
            Text(foodItem.location)
                .font(.subheadline)
            Spacer()
            Text(foodItem.statusEmoji)
        }
        .padding()
    }
}
