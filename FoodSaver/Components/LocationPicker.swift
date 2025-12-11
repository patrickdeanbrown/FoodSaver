import SwiftUI

struct LocationPicker: View {
    @Binding var location: String
    let locations: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Location")
                .font(Theme.headlineFont)
                .foregroundColor(Theme.textSecondary)
            Menu {
                ForEach(locations, id: \.self) { location in
                    Button(action: {
                        self.location = location
                    }) {
                        Text(location)
                    }
                }
            } label: {
                HStack {
                    Text(location.isEmpty ? "Select location" : location)
                        .foregroundColor(location.isEmpty ? Theme.textTertiary : Theme.textPrimary)
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
