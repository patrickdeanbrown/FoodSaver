// FoodSaver/Views/FoodItemRow.swift
import SwiftUI

struct FoodItemRow: View {
    let foodItem: FoodItem

    /// Formatter for the best before date.
    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none // No need for time in the row
        return formatter
    }()

    var body: some View {
        HStack(alignment: .top, spacing: 12) { // Added spacing
            // Status Emoji
            Text(foodItem.statusEmoji)
                .font(.title2) // Slightly larger emoji
                .padding(.top, 2) // Align a bit better with multi-line text

            VStack(alignment: .leading, spacing: 4) {
                Text(foodItem.name)
                    .font(Theme.headlineFont)
                    .foregroundColor(Theme.primaryColor)
                    .lineLimit(2) // Allow for slightly longer names

                HStack {
                    Image(systemName: "calendar") // Calendar icon
                        .font(.caption)
                        .foregroundColor(Theme.secondaryColor)
                    Text("Best Before: \(foodItem.bestBeforeDate, formatter: Self.dateFormatter)")
                        .font(Theme.bodyFont.weight(.medium)) // Make date stand out a bit
                        .foregroundColor(Theme.secondaryColor)
                }

                HStack(spacing: 4) { // For Category and Location
                    Image(systemName: "tag.fill")
                         .font(.caption)
                         .foregroundColor(Theme.secondaryColor.opacity(0.8))
                    Text(foodItem.category)
                        .font(Theme.bodyFont)
                        .foregroundColor(Theme.secondaryColor.opacity(0.8))
                        .lineLimit(1)

                    Text("·") // Separator
                        .font(Theme.bodyFont)
                        .foregroundColor(Theme.secondaryColor.opacity(0.8))
                    
                    Image(systemName: "location.fill")
                        .font(.caption)
                        .foregroundColor(Theme.secondaryColor.opacity(0.8))
                    Text(foodItem.location)
                        .font(Theme.bodyFont)
                        .foregroundColor(Theme.secondaryColor.opacity(0.8))
                        .lineLimit(1)
                }
            }

            Spacer() // Pushes content to the left and emoji to the far right if uncommented (or use it like this for left alignment of info)

            // Optional: If you still want a subtle right-side visual indicator in addition to emoji
            // Circle()
            //     .fill(foodItem.statusColor.opacity(0.7))
            //     .frame(width: 12, height: 12)
            //     .padding(.trailing, 5)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12) // Slightly more pronounced corner radius
                .fill(foodItem.statusColor.opacity(0.15)) // Use statusColor with opacity
                .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2) // Softer shadow
        )
        .padding(.vertical, 6) // Increased vertical padding between rows
        .animation(.spring(), value: foodItem.status) // Animate based on status changes too
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
