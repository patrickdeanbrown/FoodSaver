// FoodSaver/Views/FoodItemRow.swift
import SwiftUI

struct FoodItemRow: View {
    let foodItem: FoodItem
    @Environment(\.colorScheme) private var colorScheme

    /// Formatter for the best before date.
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none // No need for time in the row
        return formatter
    }()

    var body: some View {
        HStack(alignment: .top, spacing: Theme.Spacing.sm) {
            Text(foodItem.statusEmoji)
                .font(.title2)
                .padding(.top, 2)

            VStack(alignment: .leading, spacing: 6) {
                Text(foodItem.name)
                    .font(Theme.headlineFont)
                    .foregroundColor(Theme.textPrimary)
                    .lineLimit(2)

                HStack(spacing: 6) {
                    Image(systemName: "calendar")
                        .font(.caption)
                        .foregroundColor(Theme.textSecondary)
                    Text("Best Before: \(foodItem.bestBeforeDate, formatter: Self.dateFormatter)")
                        .font(Theme.bodyFont.weight(.medium))
                        .foregroundColor(Theme.textSecondary)
                }

                HStack(spacing: 6) {
                    Image(systemName: "tag.fill")
                        .font(.caption)
                        .foregroundColor(Theme.textTertiary)
                    Text(foodItem.category)
                        .font(Theme.bodyFont)
                        .foregroundColor(Theme.textTertiary)
                        .lineLimit(1)

                    Text("·")
                        .font(Theme.bodyFont)
                        .foregroundColor(Theme.textTertiary)

                    Image(systemName: "location.fill")
                        .font(.caption)
                        .foregroundColor(Theme.textTertiary)
                    Text(foodItem.location)
                        .font(Theme.bodyFont)
                        .foregroundColor(Theme.textTertiary)
                        .lineLimit(1)
                }
            }

            Spacer()
        }
        .padding(Theme.Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Theme.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Theme.statusBackground(for: foodItem.status).opacity(0.45))
                )
                .shadow(
                    color: colorScheme == .dark ? Theme.cardShadowDark : Theme.cardShadow,
                    radius: 8,
                    x: 0,
                    y: 4
                )
        )
        .padding(.vertical, Theme.Spacing.sm)
        .animation(.spring(), value: foodItem.status)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(foodItem.name), \(foodItem.status.rawValue). Best before \(Self.dateFormatter.string(from: foodItem.bestBeforeDate)). Category \(foodItem.category). Location \(foodItem.location).")
        .accessibilityHint("Swipe for actions like modify or delete.")
    }
}

struct FoodItemRow_Previews: PreviewProvider {
    static var previews: some View {
        // Create sample FoodItem instances for preview
        let freshItem = FoodItem(name: "Fresh Apples", bestBeforeDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!, category: "Produce", location: "Fridge", warningPeriod: 3)
        let expiringItem = FoodItem(name: "Milk", bestBeforeDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, category: "Dairy", location: "Fridge", warningPeriod: 3)
        let expiredItem = FoodItem(name: "Old Bread Loaf with a Very Long Name That Might Wrap", bestBeforeDate: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, category: "Bakery", location: "Pantry", warningPeriod: 3)

        return VStack {
            FoodItemRow(foodItem: freshItem)
            FoodItemRow(foodItem: expiringItem)
            FoodItemRow(foodItem: expiredItem)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}
