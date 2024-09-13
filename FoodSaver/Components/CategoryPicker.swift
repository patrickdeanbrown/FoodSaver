import SwiftUI

struct CategoryPicker: View {
    @Binding var category: String
    let categories: [String: Int]
    @Binding var warningPeriod: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text("Category")
                .font(Theme.headlineFont)
                .foregroundColor(Theme.secondaryColor)
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
                        .foregroundColor(category.isEmpty ? .gray : .primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
            }
        }
        .padding(.horizontal)
    }
}
