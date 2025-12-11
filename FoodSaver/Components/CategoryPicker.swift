import SwiftUI

struct CategoryPicker: View {
    @Binding var category: String
    let categories: [String: Int]
    @Binding var warningPeriod: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Category")
                .font(Theme.headlineFont)
                .foregroundColor(Theme.textSecondary)
            Menu {
                ForEach(categories.keys.sorted(), id: \.self) { category in
                    Button(action: {
                        self.category = category
                        self.warningPeriod = categories[category] ?? 0
                    }) {
                        Text(category)
                    }
                }
            } label: {
                HStack {
                    Text(category.isEmpty ? "Select category" : category)
                        .foregroundColor(category.isEmpty ? Theme.textTertiary : Theme.textPrimary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Theme.textTertiary)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 14)
                .background(Theme.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Theme.border, lineWidth: 1)
                )
                .cornerRadius(12)
            }
        }
        .padding(.horizontal, Theme.Spacing.md)
    }
}
