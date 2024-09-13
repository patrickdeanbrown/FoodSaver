// FoodItemRow.swift
import SwiftUI

struct FoodItemRow: View {
    let foodItem: FoodItem

    var body: some View {
        HStack {
            Text(foodItem.name)
                .font(Theme.headlineFont)
                .foregroundColor(.primary)
            Spacer()
            Text(foodItem.category)
                .font(Theme.bodyFont)
                .foregroundColor(.secondary)
            Spacer()
            Text(foodItem.location)
                .font(Theme.bodyFont)
                .foregroundColor(.secondary)
            Spacer()
            Text(foodItem.statusEmoji)
                .font(.title)
                .transition(.scale)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
        )
        .padding(.vertical, 5)
        .animation(.spring(), value: foodItem)
    }
}
