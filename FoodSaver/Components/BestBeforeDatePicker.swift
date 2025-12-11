import SwiftUI

struct BestBeforeDatePicker: View {
    @Binding var bestBeforeDate: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Best Before Date")
                .font(Theme.headlineFont)
                .foregroundColor(Theme.textSecondary)
            DatePicker("Select a Date", selection: $bestBeforeDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .tint(Theme.primaryColor)
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
                .background(Theme.surfaceAlt)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Theme.border, lineWidth: 1)
                )
                .cornerRadius(12)
        }
        .padding(.horizontal, Theme.Spacing.md)
    }
}
